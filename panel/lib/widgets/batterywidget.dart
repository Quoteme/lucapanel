import 'dart:async';
import 'dart:io';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryWidget extends StatefulWidget {
  Duration updateInterval;
  BatteryWidget({this.updateInterval = const Duration(seconds: 5), Key? key})
      : super(key: key);

  @override
  State<BatteryWidget> createState() => _BatteryWidgetState();
}

class _BatteryWidgetState extends State<BatteryWidget> {
  int? _batteryLevel;
  double? _powerUsage;
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
    Timer.periodic(widget.updateInterval, (Timer timer) {
      Process.run('cat', ['/sys/class/power_supply/BAT0/power_now'])
          .then((ProcessResult result) {
        final powerUsage = int.tryParse(result.stdout.toString());
        if (powerUsage != null) {
          setState(() {
            _powerUsage = powerUsage / 1e6;
          });
        }
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

  Color _iconColor() {
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

  Color _textColor() {
    // rotated icon color hue by 180 degrees
    return Color.fromARGB(255, 255 - _iconColor().red, 255 - _iconColor().green,
        255 - _iconColor().blue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 32,
          child: Stack(children: [
            RotatedBox(
                quarterTurns: -1,
                child: Icon(
                  _icon(),
                  color: _iconColor(),
                  size: 32,
                )),
            Center(
              child: Text(
                ' $_batteryLevel',
                textAlign: TextAlign.center,
                style: TextStyle(color: _textColor(), shadows: const [
                  Shadow(
                      color: Colors.black, offset: Offset(1, 1), blurRadius: 2)
                ]),
              ),
            ),
          ]),
        ),
        if (_powerUsage != null) Text('${_powerUsage!.toStringAsFixed(2)} W'),
      ],
    );
  }
}
