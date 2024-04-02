import 'package:my_cobra_plugin_platform_interface/my_cobra_plugin_platform_interface.dart';

MyCobraPluginPlatform get _platform => MyCobraPluginPlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}
