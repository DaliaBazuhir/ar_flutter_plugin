import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ar_plugin_platform_interface.dart';

/// An implementation of [ArPluginPlatform] that uses method channels.
class MethodChannelArPlugin extends ArPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ar_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  @override
  Future<void> showArScreen(String modelPath, {double scale = 0.001}) async {
    try {
      await MethodChannel('ar_plugin').invokeMethod('showArScreen', {
        'modelName': modelPath,
        'scale': scale,
      });
    } on PlatformException catch (e) {
      print("Error calling showArScreen: ${e.message}");
    }
  }
}
