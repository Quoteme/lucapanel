import 'package:flutter/material.dart';
import 'package:lucapanel/widgets/batterywidget.dart';
import 'package:lucapanel/widgets/calendarwidget.dart';
import 'package:lucapanel/widgets/screenbrightnesswidget.dart';
import 'package:lucapanel/widgets/volumewidget.dart';
import 'package:lucapanel/widgets/windowcontrols/closewidget.dart';
import 'package:lucapanel/widgets/windowcontrols/minimizewidget.dart';
import 'package:lucapanel/widgets/windowcontrols/unminimize.dart';
import 'package:lucapanel/widgets/workspaceswidget.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            WorkspacesWidget(),
            Row(
              children: [UnminimizeWidget(), MinimizeWidget(), CloseWidget()]
                  .map((e) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: e,
                );
              }).toList(),
            ),
            Row(
                children: [
              const VolumeWidget(),
              const ScreenBrightnessWidget(),
              const CalendarWidget(),
              const BatteryWidget(),
            ]
                    .map((e) => Padding(
                        padding: const EdgeInsets.only(left: 10), child: e))
                    .toList())
          ],
        ),
      ),
    );
  }
}
