import 'dart:io';

import 'package:flutter/material.dart';

class ScreenBrightnessWidget extends StatefulWidget {
  const ScreenBrightnessWidget({Key? key}) : super(key: key);

  @override
  State<ScreenBrightnessWidget> createState() => _ScreenBrightnessWidgetState();
}

class _ScreenBrightnessWidgetState extends State<ScreenBrightnessWidget> {
  bool _expanded = false;
  int _maxBrightness = 255;
  int? _brightness;

  double? get _brightnessPercentage =>
      _brightness != null ? (_brightness! / _maxBrightness) : null;

  Widget get _brightnessSlider => AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: !_expanded
          ? const SizedBox()
          : Slider(
              value: _brightnessPercentage!,
              allowedInteraction: SliderInteraction.tapOnly,
              onChanged: (x) async {
                print("lal");
                brightness = (x * _maxBrightness).round();
                _getBrightness();
                setState(() {});
              }));

  @override
  void initState() {
    super.initState();
    _getBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _brightnessSlider,
        _toggleExpandeIcon,
      ],
    );
  }

  Icon get _icon {
    switch (_brightnessPercentage) {
      case null:
        return const Icon(Icons.brightness_medium, color: Colors.grey);
      case <= 1 / 3:
        return const Icon(Icons.brightness_low);
      case <= 2 / 3:
        return const Icon(Icons.brightness_medium);
      default:
        return const Icon(Icons.brightness_high);
    }
  }

  // icon with gesture detector
  get _toggleExpandeIcon => GestureDetector(
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: _icon,
      );

  void _getBrightness() async {
    // run `brightnessctl max` to get the max brightness
    int? max = int.tryParse(
        (await Process.run("brightnessctl", ["max"])).stdout.toString().trim());

    // run `brightnessctl get` to get the current brightness
    int? brightness = int.tryParse(
        (await Process.run("brightnessctl", ["get"])).stdout.toString().trim());
    if (max == null || brightness == null) {
      // wait for 1 second and try again
      await Future.delayed(const Duration(seconds: 1));
      _getBrightness();
    }
    setState(() {
      _maxBrightness = max!;
      _brightness = brightness;
    });
  }

  set brightness(int value) {
    // run `brightnessctl set <value>` to set the brightness
    Process.run("brightnessctl", ["set", value.toString()]);
  }
}
