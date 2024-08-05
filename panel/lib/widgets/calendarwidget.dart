import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      setState(() {
        _date = DateTime.now();
      });
    });
  }

  get _hhmmss =>
      '${_date.hour.toString().padLeft(2, '0')}:${_date.minute.toString().padLeft(2, '0')}:${_date.second.toString().padLeft(2, '0')}';

  get _ddmmyyyy =>
      '${_date.day.toString().padLeft(2, '0')}/${_date.month.toString().padLeft(2, '0')}/${_date.year.toString().padLeft(4, '0')}';

  @override
  Widget build(BuildContext context) {
    // Display the current time in the format HH:MM:SS
    // on hover, display the current date in the format DD/MM/YYYY
    return Tooltip(
      message: _ddmmyyyy,
      preferBelow: false,
      verticalOffset: -20,
      child: Text(
        _hhmmss,
      ),
    );
  }
}
