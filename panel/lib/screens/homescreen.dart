import 'package:flutter/material.dart';
import 'package:lucapanel/widgets/batterywidget.dart';
import 'package:lucapanel/widgets/calendarwidget.dart';
import 'package:lucapanel/widgets/screenbrightnesswidget.dart';

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
                children: [
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
