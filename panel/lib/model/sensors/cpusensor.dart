import 'dart:io';

import 'package:lucapanel/model/sensors/sensor.dart';

class CpuSensor extends Sensor {
  @override
  String get sensorName => "k10temp";

  @override
  get maxValue => 100;

  @override
  get minValue => 0;
}
