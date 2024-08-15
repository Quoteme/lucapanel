import 'package:flutter_test/flutter_test.dart';
import 'package:stalonetray_plugin/stalonetray_plugin.dart';
import 'package:stalonetray_plugin/stalonetray_plugin_platform_interface.dart';
import 'package:stalonetray_plugin/stalonetray_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockStalonetrayPluginPlatform
    with MockPlatformInterfaceMixin
    implements StalonetrayPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final StalonetrayPluginPlatform initialPlatform = StalonetrayPluginPlatform.instance;

  test('$MethodChannelStalonetrayPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStalonetrayPlugin>());
  });

  test('getPlatformVersion', () async {
    StalonetrayPlugin stalonetrayPlugin = StalonetrayPlugin();
    MockStalonetrayPluginPlatform fakePlatform = MockStalonetrayPluginPlatform();
    StalonetrayPluginPlatform.instance = fakePlatform;

    expect(await stalonetrayPlugin.getPlatformVersion(), '42');
  });
}
