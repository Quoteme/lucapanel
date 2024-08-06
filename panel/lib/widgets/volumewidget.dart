import 'dart:io';

import 'package:flutter/material.dart';

class VolumeWidget extends StatefulWidget {
  const VolumeWidget({Key? key}) : super(key: key);

  @override
  State<VolumeWidget> createState() => _VolumeWidgetState();
}

class _VolumeWidgetState extends State<VolumeWidget> {
  bool _expanded = false;
  int? _volume;
  bool? _mute;

  @override
  void initState() {
    super.initState();
    _fetchVolume();
    _fetchMute();
  }

  Widget get _slider => AnimatedSize(
      duration: Duration(milliseconds: 200),
      child: !_expanded
          ? const SizedBox()
          : _volume == null
              ? CircularProgressIndicator()
              : Slider(
                  value: _volume!.toDouble(),
                  min: 0,
                  max: 100,
                  allowedInteraction: SliderInteraction.tapOnly,
                  onChanged: (v) {
                    _setVolume(v.round());
                    _fetchVolume();
                  }));

  Icon get _icon {
    switch (_mute) {
      case null:
        return const Icon(Icons.music_off, color: Colors.grey);
      case true:
        return const Icon(Icons.music_off);
      case false:
        return const Icon(Icons.music_note);
    }
  }

  Widget get _toggleExpandeIcon => GestureDetector(
        onTap: () => setState(() => _expanded = !_expanded),
        child: _icon,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [_slider, _toggleExpandeIcon],
    );
  }

  void _fetchVolume() async {
    final result = (await Process.run('pamixer', ['--get-volume']))
        .stdout
        .toString()
        .trim();
    final vol = int.tryParse(result) ?? 0;
    setState(() {
      _volume = vol;
    });
  }

  void _fetchMute() async {
    final result =
        (await Process.run('pamixer', ['--get-mute'])).stdout.toString().trim();
    final mute = result == 'true';
    setState(() {
      _mute = mute;
    });
  }

  void _setVolume(int v) {
    Process.run('pamixer', ['--set-volume', v.toString()]);
  }
}
