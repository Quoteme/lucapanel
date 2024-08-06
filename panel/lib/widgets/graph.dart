import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  final List<List<double>> data;
  final double max;
  final double min;
  final Color color;
  const Graph(this.data,
      {super.key, this.max = 100, this.min = 0, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GraphPainter(data, max: max, min: min, color: color),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<List<double>> data;
  final double max;
  final double min;
  final Color color;
  GraphPainter(this.data,
      {this.max = 100, this.min = 0, this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) {
      return;
    }
    List<List<double>> transposed = List.generate(data.first.length,
        (i) => List.generate(data.length, (j) => data[j][i]));
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (List<double> sensor in transposed) {
      final path = Path();
      var x = 0.0;
      var y = size.height - (sensor.first - min) / (max - min) * size.height;
      path.moveTo(x, y);
      for (int i = 0; i <= sensor.length - 1; i++) {
        x = i * size.width / (sensor.length - 1);
        y = size.height - (sensor[i] - min) / (max - min) * size.height;
        path.lineTo(x, y);
      }
      // fill bottom
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
