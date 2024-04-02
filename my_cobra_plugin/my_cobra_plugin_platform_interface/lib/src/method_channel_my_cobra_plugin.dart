import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:my_cobra_plugin_platform_interface/my_cobra_plugin_platform_interface.dart';

/// An implementation of [MyCobraPluginPlatform] that uses method channels.
class MethodChannelMyCobraPlugin extends MyCobraPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_cobra_plugin');

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Future<void> dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  Future<void> initializeCobra(String accessKey) {
    // TODO: implement initializeCobra
    throw UnimplementedError();
  }

  @override
  Future<double> processAudioFrame(List<int> frame) {
    // TODO: implement processAudioFrame
    throw UnimplementedError();
  }
}
