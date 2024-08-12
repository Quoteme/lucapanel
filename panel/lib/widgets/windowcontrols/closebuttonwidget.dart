import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucapanel/screens/shutdownscreen.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

  _closeFocusedWindow() async {
    final active = (await Process.run('xdotool', ['getactivewindow']))
        .stdout
        .toString()
        .trim();
    Process.run('xdotool', ['windowclose', active]);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _closeFocusedWindow,
      onLongPress: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ShutdownScreen())),
      child: const Icon(Icons.circle, color: Colors.red),
    );
  }
}
