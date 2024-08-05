import 'dart:async';

import 'package:flutter/material.dart';
import 'package:system_windows/system_windows.dart';

class WindowlistWidget extends StatefulWidget {
  const WindowlistWidget({Key? key}) : super(key: key);

  @override
  State<WindowlistWidget> createState() => _WindowlistWidgetState();
}

class _WindowlistWidgetState extends State<WindowlistWidget> {
  List<SystemWindow> _windows = <SystemWindow>[];

  @override
  void initState() {
    super.initState();
    SystemWindows().getActiveApps().then((List<SystemWindow> windows) {
      setState(() {
        _windows = windows;
      });
    });
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      SystemWindows().getActiveApps().then((List<SystemWindow> windows) {
        setState(() {
          _windows = windows;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final SystemWindow window in _windows)
          Tooltip(
            message: window.title,
            child: Text(
              window.title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
