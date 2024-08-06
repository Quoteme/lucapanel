import 'dart:io';

class Sensor {
  Directory? _cachedHwmonDirectory;

  String get sensorName => "k10temp";

  Future<Directory?> get hwmonDirectory async {
    _cachedHwmonDirectory ??= Directory("/sys/class/hwmon")
        .listSync()
        .whereType<Directory>()
        .firstWhere((dir) =>
            File("${dir.path}/name").readAsStringSync().contains(sensorName));
    return _cachedHwmonDirectory;
  }

  /// Content of the file with the given [name] in the [hwmonDirectory].
  Future<String?> get name async => (await hwmonDirectory)
      ?.listSync()
      .whereType<File>()
      .firstWhere((file) => file.path.endsWith("name"))
      .readAsString();

  get updateInterval => const Duration(seconds: 1);

  get valueFiles => ["temp1_input"];

  double get maxValue => 100;

  double get minValue => 0;

  // periodically read the `temp1_input` file and return the value
  Stream<List<double>?> get values async* {
    await for (var _ in Stream.periodic(updateInterval)) {
      final directory = await hwmonDirectory;
      final files = directory
          ?.listSync()
          .whereType<File>()
          .where((file) => valueFiles.contains(file.path.split("/").last))
          .map((file) => double.parse(file.readAsStringSync()) / 1000)
          .toList();
      yield files;
    }
  }

  Stream<List<List<double>>> valuesBuffered({int bufferSize = 3}) async* {
    final buffer = <List<double>>[];
    await for (var values in values.where((values) => values != null)) {
      buffer.add(values!);
      if (buffer.length > bufferSize) {
        buffer.removeAt(0);
      }
      yield buffer;
    }
  }
}
