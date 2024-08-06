import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';

class VolumeWidget extends StatefulWidget {
  const VolumeWidget({Key? key}) : super(key: key);

  @override
  State<VolumeWidget> createState() => _VolumeWidgetState();
}

class _VolumeWidgetState extends State<VolumeWidget> {
  bool _expanded = false;
  double? _volume;
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
                  value: _volume!,
                  allowedInteraction: SliderInteraction.tapOnly,
                  onChanged: (v) {
                    FlutterVolumeController.setVolume(v);
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
    final vol = await FlutterVolumeController.getVolume();
    setState(() {
      _volume = vol;
    });
  }

  void _fetchMute() async {
    final mute = await FlutterVolumeController.getMute();
    setState(() {
      _mute = mute;
    });
  }
}
