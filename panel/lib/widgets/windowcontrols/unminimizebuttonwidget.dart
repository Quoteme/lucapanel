import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucapanel/screens/unminimizescreen.dart';

class UnminimizeButtonWidget extends StatelessWidget {
  const UnminimizeButtonWidget({super.key});

  _showUnminimizationList(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const Unminimizescreen()));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showUnminimizationList(context),
      onLongPress: () => _showUnminimizationList(context),
      child: const Icon(Icons.circle, color: Colors.green),
    );
  }
}
