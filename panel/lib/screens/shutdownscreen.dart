import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucapanel/widgets/backbuttonwidget.dart';

class ShutdownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        BackButtonWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _shutdownButton(context),
            _hibernateButton(context),
            _logoutButton(context),
          ]
              .map((e) =>
                  Padding(padding: const EdgeInsets.only(left: 8.0), child: e))
              .toList(),
        )
      ]),
    );
  }

  _shutdownButton(BuildContext context) => ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () => Process.run('shutdown', ['now']),
        icon: const Icon(Icons.power_settings_new),
        label: const Text('Shutdown'),
      );

  _hibernateButton(BuildContext context) => ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () => Process.run('systemctl', ['hibernate']),
        icon: const Icon(Icons.bedtime),
        label: const Text('Hibernate'),
      );

  _logoutButton(BuildContext context) => ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
            foregroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () => Process.run('killall', ['.xmonad-luca-wrapped']),
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
      );
}
