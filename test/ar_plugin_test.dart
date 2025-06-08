import 'package:flutter_test/flutter_test.dart';
import 'package:ar_plugin/ar_plugin.dart';
import 'package:ar_plugin/ar_plugin_platform_interface.dart';
import 'package:ar_plugin/ar_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockArPluginPlatform
    with MockPlatformInterfaceMixin
    implements ArPluginPlatform {

  bool showArScreenCalled = false;
  String? receivedModelPath;
  double? receivedScale;

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> showArScreen(String modelPath, {double scale = 0.001}) async {
    showArScreenCalled = true;
    receivedModelPath = modelPath;
    receivedScale = scale;
  }
}

void main() {
  final ArPluginPlatform initialPlatform = ArPluginPlatform.instance;

  test('$MethodChannelArPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelArPlugin>());
  });

  test('getPlatformVersion returns "42"', () async {
    ArPlugin arPlugin = ArPlugin();
    MockArPluginPlatform fakePlatform = MockArPluginPlatform();
    ArPluginPlatform.instance = fakePlatform;

    expect(await arPlugin.getPlatformVersion(), '42');
  });

  test('showArScreen is called with correct model path and scale', () async {
    final mockPlatform = MockArPluginPlatform();
    ArPluginPlatform.instance = mockPlatform;

    final arPlugin = ArPlugin();
  });
}
