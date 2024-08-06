import 'package:flutter/material.dart';
import 'package:lucapanel/model/sensors/amdgpu.dart';
import 'package:lucapanel/model/sensors/cpusensor.dart';
import 'package:lucapanel/widgets/graph.dart';
import 'package:lucapanel/widgets/sensors/sensorwidget.dart';

class AmdGpuSensorWidget extends StatelessWidget {
  const AmdGpuSensorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SensorWidget(AmdGpuSensor());
  }
}
