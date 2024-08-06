import 'package:dbus/dbus.dart';

class Focusedwindow {
  late String name;

  Focusedwindow({required this.name});

  static Stream<Focusedwindow> get focusedWindowStream {
    final client = DBusClient.session();
    return DBusSignalStream(
      client,
      interface: 'org.xmonad.bus',
      path: DBusObjectPath('/general'),
      name: 'WindowChanged',
    ).map((event) {
      return Focusedwindow(
        name: (event.values.first as DBusString).value,
      );
    });
  }
}
