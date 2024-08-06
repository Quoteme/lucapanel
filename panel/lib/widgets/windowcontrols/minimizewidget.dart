import 'dart:io';

import 'package:flutter/material.dart';

class MinimizeWidget extends StatelessWidget {
  const MinimizeWidget({super.key});

  _minimizeFocusedWindow() async {
    final active = (await Process.run('xdotool', ['getactivewindow']))
        .stdout
        .toString()
        .trim();
    Process.run('xdotool', ['windowminimize', active]);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _minimizeFocusedWindow,
      child: const Icon(Icons.circle, color: Colors.yellow),
    );
  }
}
