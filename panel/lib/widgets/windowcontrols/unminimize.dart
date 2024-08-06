import 'dart:io';

import 'package:flutter/material.dart';

class UnminimizeWidget extends StatelessWidget {
  const UnminimizeWidget({super.key});

  _showUnminimizationList() async {
    // TODO: Implement this method
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showUnminimizationList,
      child: const Icon(Icons.circle, color: Colors.green),
    );
  }
}
