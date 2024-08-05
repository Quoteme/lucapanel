import 'package:flutter/material.dart';
import 'package:lucapanel/screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
          tooltipTheme: TooltipThemeData(
            decoration: BoxDecoration(
              color: Colors.black, // Dark background
              borderRadius: BorderRadius.circular(4),
            ),
            textStyle: TextStyle(
              color: Colors.white, // White text
            ),
          )),
      themeMode: ThemeMode.dark, // Use dark theme
      home: const Homescreen(),
    );
  }
}
