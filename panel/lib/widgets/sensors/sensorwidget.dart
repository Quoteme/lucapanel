import 'package:flutter/material.dart';
import 'package:lucapanel/model/sensors/sensor.dart';
import 'package:lucapanel/widgets/graph.dart';

class SensorWidget extends StatelessWidget {
  final Sensor sensor;
  final Color color;
  final int bufferSize;
  const SensorWidget(this.sensor,
      {Key? key, this.color = Colors.red, this.bufferSize = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: sensor.valuesBuffered(bufferSize: bufferSize),
        builder:
            (BuildContext context, AsyncSnapshot<List<List<double>>> snapshot) {
          if (snapshot.hasData) {
            var transposed = List.generate(
                snapshot.data!.first.length,
                (i) => List.generate(
                    snapshot.data!.length, (j) => snapshot.data![j][i]));
            var avgs =
                transposed.map((v) => v.reduce((a, b) => a + b) / v.length);
            return Tooltip(
              message: sensor.sensorName,
              preferBelow: false,
              verticalOffset: 0,
              child: SizedBox(
                width: 100,
                height: 32,
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 100,
                        height: 32,
                        child: Graph(snapshot.data!,
                            max: sensor.maxValue,
                            min: sensor.minValue,
                            color: color),
                      ),
                    ),
                    Center(
                        child: Text(
                            "${avgs.last.toStringAsFixed(2)}${sensor.unit}")),
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
