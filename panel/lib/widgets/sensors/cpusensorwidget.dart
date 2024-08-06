import 'package:flutter/material.dart';
import 'package:lucapanel/model/sensors/cpusensor.dart';

class CpuSensorWidget extends StatelessWidget {
  const CpuSensorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CpuSensor().values,
        builder: (BuildContext context, AsyncSnapshot<List<double>> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.first.toString());
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
