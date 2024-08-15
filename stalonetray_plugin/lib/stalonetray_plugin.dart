
import 'stalonetray_plugin_platform_interface.dart';

class StalonetrayPlugin {
  Future<String?> getPlatformVersion() {
    return StalonetrayPluginPlatform.instance.getPlatformVersion();
  }
}
