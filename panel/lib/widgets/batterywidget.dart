import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryWidget extends StatefulWidget {
  const BatteryWidget({Key? key}) : super(key: key);

  @override
  State<BatteryWidget> createState() => _BatteryWidgetState();
}

class _BatteryWidgetState extends State<BatteryWidget> {
  int? _batteryLevel;
  BatteryState? _batteryState;

  @override
  void initState() {
    super.initState();
    Battery().batteryLevel.then((int value) {
      setState(() {
        _batteryLevel = value;
      });
    });
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      Battery().batteryLevel.then((int value) {
        setState(() {
          _batteryLevel = value;
        });
      });
    });
    Battery().batteryState.then((BatteryState state) {
      setState(() {
        _batteryState = state;
      });
    });
    Battery().onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
      });
    });
  }

  IconData _icon() {
    const steps = 8;
    const stepSize = 100 / steps;
    switch (_batteryLevel) {
      case null:
        return Icons.battery_unknown;
      case >= 100 - stepSize:
        return Icons.battery_full;
      case >= 100 - stepSize * 2:
        return Icons.battery_6_bar;
      case >= 100 - stepSize * 3:
        return Icons.battery_5_bar;
      case >= 100 - stepSize * 4:
        return Icons.battery_4_bar;
      case >= 100 - stepSize * 5:
        return Icons.battery_3_bar;
      case >= 100 - stepSize * 6:
        return Icons.battery_2_bar;
      case >= 100 - stepSize * 7:
        return Icons.battery_1_bar;
      default:
        return Icons.battery_alert;
    }
  }

  _iconColor() {
    switch (_batteryState) {
      case BatteryState.charging:
        return Colors.lightGreen;
      case BatteryState.discharging:
        return _batteryLevel != null && _batteryLevel! < 20
            ? Colors.red
            : Colors.yellow;
      case BatteryState.connectedNotCharging:
        return Colors.blue;
      case BatteryState.full:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(_icon(), color: _iconColor()),
        Text('$_batteryLevel%'),
      ],
    );
  }
}
