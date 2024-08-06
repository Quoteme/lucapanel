import 'package:flutter/material.dart';
import 'package:lucapanel/widgets/batterywidget.dart';
import 'package:lucapanel/widgets/calendarwidget.dart';
import 'package:lucapanel/widgets/screenbrightnesswidget.dart';
import 'package:lucapanel/widgets/sensors/amdgpuwidget.dart';
import 'package:lucapanel/widgets/sensors/cpusensorwidget.dart';
import 'package:lucapanel/widgets/volumewidget.dart';
import 'package:lucapanel/widgets/windowcontrols/closebuttonwidget.dart';
import 'package:lucapanel/widgets/windowcontrols/minimizebuttonwidget.dart';
import 'package:lucapanel/widgets/windowcontrols/unminimizebuttonwidget.dart';
import 'package:lucapanel/widgets/windowtitlewidget.dart';
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
            const WorkspacesWidget(),
            Row(
              children: [
                const WindowtitleWidget(),
                const UnminimizeButtonWidget(),
                const MinimizeButtonWidget(),
                const CloseButtonWidget()
              ].map((e) {
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
              const CpuSensorWidget(),
              const AmdGpuSensorWidget(),
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
