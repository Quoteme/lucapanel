import 'package:flutter/material.dart';
import 'package:lucapanel/model/focusedWindow.dart';

class WindowtitleWidget extends StatelessWidget {
  const WindowtitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: StreamBuilder(
          stream: Focusedwindow.focusedWindowStream,
          builder:
              (BuildContext context, AsyncSnapshot<Focusedwindow> snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.name,
                softWrap: false,
                textAlign: TextAlign.right,
                overflow: TextOverflow.fade,
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
