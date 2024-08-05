import 'dart:io';

class Workspace {
  late String name;
  late bool active;

  Workspace({required this.name, required this.active});

  static Future<List<Workspace>> fromWmctrl() async {
    final List<Workspace> workspaces = [];
    final List<String> wmctrl = await Process.run('wmctrl', ['-d'])
        .then((result) => result.stdout.split('\n'));
    for (final line in wmctrl) {
      if (line.isNotEmpty) {
        final List<String> parts =
            line.split(' ').where((element) => element.isNotEmpty).toList();
        workspaces.add(Workspace(name: parts[0], active: parts[1] == '*'));
      }
    }
    return workspaces;
  }
}
