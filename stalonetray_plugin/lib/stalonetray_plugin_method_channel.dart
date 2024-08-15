import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'stalonetray_plugin_platform_interface.dart';

/// An implementation of [StalonetrayPluginPlatform] that uses method channels.
class MethodChannelStalonetrayPlugin extends StalonetrayPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('stalonetray_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
