import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_cobra_plugin/my_cobra_plugin.dart';
import 'package:my_cobra_plugin_platform_interface/my_cobra_plugin_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyCobraPluginPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements MyCobraPluginPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyCobraPlugin', () {
    late MyCobraPluginPlatform myCobraPluginPlatform;

    setUp(() {
      myCobraPluginPlatform = MockMyCobraPluginPlatform();
      MyCobraPluginPlatform.instance = myCobraPluginPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => myCobraPluginPlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => myCobraPluginPlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
