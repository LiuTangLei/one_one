import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_cobra_plugin_android/my_cobra_plugin_android.dart';
import 'package:my_cobra_plugin_platform_interface/my_cobra_plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyCobraPluginAndroid', () {
    const kPlatformName = 'Android';
    late MyCobraPluginAndroid myCobraPlugin;
    late List<MethodCall> log;

    setUp(() async {
      myCobraPlugin = MyCobraPluginAndroid();

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
      MyCobraPluginAndroid.registerWith();
      expect(MyCobraPluginPlatform.instance, isA<MyCobraPluginAndroid>());
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
