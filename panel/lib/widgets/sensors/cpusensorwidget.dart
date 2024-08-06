import 'package:flutter/material.dart';
import 'package:lucapanel/model/sensors/cpusensor.dart';

class CpuSensorWidget extends StatelessWidget {
  const CpuSensorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CpuSensor().valuesBuffered(bufferSize: 10),
        builder:
            (BuildContext context, AsyncSnapshot<List<List<double>>> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.toString());
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
