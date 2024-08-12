import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';
import 'package:lucapanel/model/workspace.dart';

class WorkspacesWidget extends StatefulWidget {
  const WorkspacesWidget({Key? key}) : super(key: key);

  @override
  State<WorkspacesWidget> createState() => _WorkspacesWidgetState();
}

class _WorkspacesWidgetState extends State<WorkspacesWidget> {
  List<Workspace> workspaces = [];

  @override
  void initState() {
    super.initState();
    _fetchWorkspaces();
    Workspace.fromDbusStream().listen((event) {
      setState(() {
        workspaces = event;
      });
    });
  }

  _fetchWorkspaces() => Workspace.fromWmctrl().then((value) {
        setState(() {
          workspaces = value;
        });
      });

  _goToWorkspace(Workspace workspace) async {
    await Process.run('wmctrl', ['-s', workspace.index.toString()]);
    _fetchWorkspaces();
  }

  _moveToWorkspace(Workspace workspace) async {
    var window = (await Process.run('xdotool', ['getactivewindow']))
        .stdout
        .toString()
        .trim();
    Process.run('wmctrl', ['-ir', window, '-t', workspace.index.toString()]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final workspace in workspaces)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              style: workspace.focused
                  ? ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue))
                  : null,
              child: Text(workspace.name),
              onPressed: () => _goToWorkspace(workspace),
              onLongPress: () => _moveToWorkspace(workspace),
            ),
          ),
      ],
    );
  }
}
