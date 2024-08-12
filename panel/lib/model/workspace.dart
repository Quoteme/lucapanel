import 'dart:io';

import 'package:dbus/dbus.dart';

class Workspace {
  late int index;
  late String name;
  late bool focused;
  late bool visible;

  Workspace(
      {required this.index,
      required this.name,
      this.focused = false,
      this.visible = false});

  static Future<List<Workspace>> fromWmctrl() async {
    final List<Workspace> workspaces = [];
    final List<String> wmctrl = await Process.run('wmctrl', ['-d'])
        .then((result) => result.stdout.split('\n'));
    for (final line in wmctrl) {
      if (line.isNotEmpty) {
        final List<String> parts =
            line.split(' ').where((element) => element.isNotEmpty).toList();
        workspaces.add(Workspace(
            index: int.parse(parts.first),
            name: parts.last,
            focused: parts[1] == '*'));
      }
    }
    return workspaces;
  }

  static Stream<List<Workspace>> fromDbusStream() {
    final client = DBusClient.session();
    return DBusSignalStream(
      client,
      interface: 'org.xmonad.bus',
      path: DBusObjectPath('/general'),
      name: 'WorkspacesChanged',
    ).map((event) {
      return (event.values.first as DBusArray)
          .children
          .indexed
          .map((indexedValue) {
        final (index, value) = indexedValue;
        return Workspace(
          index: index,
          name: ((value as DBusStruct).children[0] as DBusString).value,
          focused: ((value as DBusStruct).children[1] as DBusBoolean).value,
          visible: ((value as DBusStruct).children[2] as DBusBoolean).value,
        );
      }).toList();
    });
  }

  static Future<List<Workspace>> fromDbusMethod() async {
    final client = DBusClient.session();
    final response = await DBusRemoteObject(client,
            name: 'org.xmonad.bus', path: DBusObjectPath('/general'))
        .callMethod('org.xmonad.bus', 'Workspaces', [],
            replySignature: DBusSignature('a(sbb)'));
    final workspaces = response.values[0];
    return (workspaces as DBusArray).children.indexed.map((indexedValue) {
      final (index, value) = indexedValue;
      return Workspace(
        index: index,
        name: ((value as DBusStruct).children[0] as DBusString).value,
        focused: ((value as DBusStruct).children[1] as DBusBoolean).value,
        visible: ((value as DBusStruct).children[2] as DBusBoolean).value,
      );
    }).toList();
  }
}
