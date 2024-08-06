import 'dart:io';

import 'package:lucapanel/model/sensors/sensor.dart';

class CpuSensor extends Sensor {
  CpuSensor() : super(hwmonDirectory: Directory("/sys/class/hwmon/hwmon1"));

  @override
  get maxValue => 100;

  @override
  get minValue => 0;

  @override
  get unit => "°C";
}
