import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'stalonetray_plugin_method_channel.dart';

abstract class StalonetrayPluginPlatform extends PlatformInterface {
  /// Constructs a StalonetrayPluginPlatform.
  StalonetrayPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static StalonetrayPluginPlatform _instance = MethodChannelStalonetrayPlugin();

  /// The default instance of [StalonetrayPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelStalonetrayPlugin].
  static StalonetrayPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StalonetrayPluginPlatform] when
  /// they register themselves.
  static set instance(StalonetrayPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
