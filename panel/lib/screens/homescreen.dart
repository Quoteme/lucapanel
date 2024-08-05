import 'package:flutter/material.dart';
import 'package:lucapanel/widgets/batterywidget.dart';
import 'package:lucapanel/widgets/calendarwidget.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('...'),
            Row(
              children: [
                CalendarWidget(),
                BatteryWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
