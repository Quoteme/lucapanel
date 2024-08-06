import 'dart:io';

import 'package:dbus/dbus.dart';

class Minimizedwindow {
  late int xid;
  late String name;

  Minimizedwindow({required this.xid, required this.name});

  unminimize() async {
    Process.run('xdotool', ['windowactivate', xid.toString()]);
  }

  static Stream<List<Minimizedwindow>> get fromDBusStream {
    final client = DBusClient.session();
    return DBusSignalStream(
      client,
      interface: 'org.xmonad.bus',
      path: DBusObjectPath('/general'),
      name: 'MinimizedWindowsChanged',
    ).map((event) {
      final minimizedWindows = event.values[0] as DBusVariant;
      return (minimizedWindows.value as DBusArray).children.map((value) {
        return Minimizedwindow(
          xid: ((((value as DBusVariant).value as DBusStruct).children[0]
                      as DBusVariant)
                  .value as DBusUint64)
              .value,
          name: ((((value as DBusVariant).value as DBusStruct).children[1]
                      as DBusVariant)
                  .value as DBusString)
              .value,
        );
      }).toList();
    });
  }

  static Future<List<Minimizedwindow>> get fromDBusMethod async {
    final client = DBusClient.session();
    final response = await DBusRemoteObject(client,
            name: 'org.xmonad.bus', path: DBusObjectPath('/general'))
        .callMethod('org.xmonad.bus', 'MinimizedWindows', [],
            replySignature: DBusSignature('a(ts)'));
    final minimizedWindows = response.values[0];
    return (minimizedWindows as DBusArray).children.map((value) {
      return Minimizedwindow(
        xid: ((value as DBusStruct).children[0] as DBusUint64).value,
        name: ((value as DBusStruct).children[1] as DBusString).value,
      );
    }).toList();
  }
}
