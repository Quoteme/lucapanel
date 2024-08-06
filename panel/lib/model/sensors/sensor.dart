import 'dart:io';

class Sensor {
  Directory hwmonDirectory;

  Sensor({required this.hwmonDirectory});

  /// Content of the file with the given [name] in the [hwmonDirectory].
  Future<String> get name async => hwmonDirectory
      .listSync()
      .whereType<File>()
      .firstWhere((file) => file.path.endsWith("name"))
      .readAsString();

  String get unit => "N/A";

  get updateInterval => const Duration(seconds: 1);

  get valueFiles => ["temp1_input"];

  double get maxValue => 100;

  double get minValue => 0;

  // periodically read the `temp1_input` file and return the value
  Stream<List<double>> get values => Stream.periodic(
        updateInterval,
        (_) => hwmonDirectory
            .listSync()
            .whereType<File>()
            .where((file) => valueFiles.contains(file.path.split("/").last))
            .map((file) => double.parse(file.readAsStringSync()) / 1000)
            .toList(),
      );

  static Future<List<Sensor>> listAll() async {
    List<Directory> hwmonDirectories = Directory("/sys/class/hwmon")
        .listSync()
        .whereType<Directory>()
        .toList();
    return hwmonDirectories.map((dir) => Sensor(hwmonDirectory: dir)).toList();
  }
}
