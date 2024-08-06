import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucapanel/model/minimizedWindow.dart';
import 'package:lucapanel/widgets/unminimizewidget.dart';

class Unminimizescreen extends StatefulWidget {
  const Unminimizescreen({Key? key}) : super(key: key);

  @override
  State<Unminimizescreen> createState() => _UnminimizescreenState();
}

class _UnminimizescreenState extends State<Unminimizescreen> {
  List<Minimizedwindow> minimizedWindows = [];
  late StreamSubscription<List<Minimizedwindow>> _minimizedWindowsSubscription;

  @override
  void initState() {
    super.initState();
    Minimizedwindow.fromDBusMethod.then((value) {
      setState(() {
        minimizedWindows = value;
      });
    });
    _minimizedWindowsSubscription =
        Minimizedwindow.fromDBusStream.listen((event) {
      setState(() {
        minimizedWindows = event;
      });
    });
  }

  @override
  void dispose() {
    _minimizedWindowsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("Back"),
            ),
            Row(
              children: minimizedWindows.map((win) {
                return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: UnminimizeWidget(minimizedWindow: win));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
