
import 'ar_plugin_platform_interface.dart';

class ArPlugin {
  Future<String?> getPlatformVersion() {
    return ArPluginPlatform.instance.getPlatformVersion();
  }
  Future<void> showArScreen(String modelPath, {double scale = 0.001}) {
    return ArPluginPlatform.instance.showArScreen(modelPath, scale: scale);
  }
}
