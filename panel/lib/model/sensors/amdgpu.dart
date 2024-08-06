import 'dart:io';

import 'package:lucapanel/model/sensors/sensor.dart';

class AmdGpuSensor extends Sensor {
  AmdGpuSensor({Duration updateInterval = const Duration(seconds: 1)})
      : super(updateInterval: updateInterval);

  @override
  String get sensorName => "amdgpu";

  @override
  get maxValue => 100;

  @override
  get minValue => 0;
}
