import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ar_plugin_method_channel.dart';

abstract class ArPluginPlatform extends PlatformInterface {
  /// Constructs a ArPluginPlatform.
  ArPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ArPluginPlatform _instance = MethodChannelArPlugin();

  /// The default instance of [ArPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelArPlugin].
  static ArPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ArPluginPlatform] when
  /// they register themselves.
  static set instance(ArPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> showArScreen(String modelPath, {double scale = 0.001}) {
    throw UnimplementedError('showArScreen() has not been implemented.');
  }
}
