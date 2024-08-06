import 'package:flutter/material.dart';
import 'package:lucapanel/model/sensors/amdgpu.dart';

class AmdGpuSensorWidget extends StatelessWidget {
  const AmdGpuSensorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AmdGpuSensor().values,
        builder: (BuildContext context, AsyncSnapshot<List<double>?> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.first.toString());
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
