import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:my_cobra_plugin_platform_interface/my_cobra_plugin_platform_interface.dart';

/// The Android implementation of [MyCobraPluginPlatform].
class MyCobraPluginAndroid extends MyCobraPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_cobra_plugin_android');

  /// Registers this class as the default instance of [MyCobraPluginPlatform]
  static void registerWith() {
    MyCobraPluginPlatform.instance = MyCobraPluginAndroid();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Future<void> initializeCobra(String accessKey) async {
    await methodChannel
        .invokeMethod('initializeCobra', {'accessKey': accessKey});
  }

  @override
  Future<double> processAudioFrame(List<int> frame) async {
    final dynamic result =
        await methodChannel.invokeMethod('processAudioFrame', {'frame': frame});
    final voiceProbability = result as double;
    return voiceProbability;
  }

  @override
  Future<void> dispose() async {
    await methodChannel.invokeMethod('dispose');
  }
}
