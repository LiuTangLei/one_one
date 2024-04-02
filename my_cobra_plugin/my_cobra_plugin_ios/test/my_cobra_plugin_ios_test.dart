import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_cobra_plugin_ios/my_cobra_plugin_ios.dart';
import 'package:my_cobra_plugin_platform_interface/my_cobra_plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyCobraPluginIOS', () {
    const kPlatformName = 'iOS';
    late MyCobraPluginIOS myCobraPlugin;
    late List<MethodCall> log;

    setUp(() async {
      myCobraPlugin = MyCobraPluginIOS();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(myCobraPlugin.methodChannel, (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      MyCobraPluginIOS.registerWith();
      expect(MyCobraPluginPlatform.instance, isA<MyCobraPluginIOS>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await myCobraPlugin.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
