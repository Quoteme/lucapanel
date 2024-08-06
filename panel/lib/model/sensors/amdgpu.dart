import 'dart:io';

import 'package:lucapanel/model/sensors/sensor.dart';

class AmdGpuSensor extends Sensor {
  @override
  String get sensorName => "amdgpu";

  @override
  get maxValue => 100;

  @override
  get minValue => 0;
}
