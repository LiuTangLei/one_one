import 'dart:ffi';

import 'package:my_cobra_plugin_platform_interface/src/method_channel_my_cobra_plugin.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of my_cobra_plugin must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `MyCobraPlugin`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [MyCobraPluginPlatform] methods.
abstract class MyCobraPluginPlatform extends PlatformInterface {
  /// Constructs a MyCobraPluginPlatform.
  MyCobraPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyCobraPluginPlatform _instance = MethodChannelMyCobraPlugin();

  /// The default instance of [MyCobraPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyCobraPlugin].
  static MyCobraPluginPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [MyCobraPluginPlatform] when they register themselves.
  static set instance(MyCobraPluginPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<String?> getPlatformName();
  Future<void> initializeCobra(String accessKey);
  Future<double> processAudioFrame(List<int> frame);
  Future<void> dispose();
}
