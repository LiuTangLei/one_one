import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_cobra_plugin_platform_interface/src/method_channel_my_cobra_plugin.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kPlatformName = 'platformName';

  group('$MethodChannelMyCobraPlugin', () {
    late MethodChannelMyCobraPlugin methodChannelMyCobraPlugin;
    final log = <MethodCall>[];

    setUp(() async {
      methodChannelMyCobraPlugin = MethodChannelMyCobraPlugin();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        methodChannelMyCobraPlugin.methodChannel,
        (methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'getPlatformName':
              return kPlatformName;
            default:
              return null;
          }
        },
      );
    });

    tearDown(log.clear);

    test('getPlatformName', () async {
      final platformName = await methodChannelMyCobraPlugin.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(platformName, equals(kPlatformName));
    });
  });
}
