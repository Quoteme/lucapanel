import 'package:flutter/material.dart';
import 'package:lucapanel/model/minimizedWindow.dart';

class UnminimizeWidget extends StatelessWidget {
  final Minimizedwindow minimizedWindow;
  const UnminimizeWidget({Key? key, required this.minimizedWindow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          minimizedWindow.unminimize();
        },
        child: Text(
          minimizedWindow.name,
          overflow: TextOverflow.fade,
          softWrap: false,
        ));
  }
}
