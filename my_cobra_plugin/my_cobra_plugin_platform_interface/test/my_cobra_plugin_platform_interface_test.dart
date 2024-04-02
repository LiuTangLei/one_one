import 'package:flutter_test/flutter_test.dart';
import 'package:my_cobra_plugin_platform_interface/my_cobra_plugin_platform_interface.dart';

class MyCobraPluginMock extends MyCobraPluginPlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;

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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('MyCobraPluginPlatformInterface', () {
    late MyCobraPluginPlatform myCobraPluginPlatform;

    setUp(() {
      myCobraPluginPlatform = MyCobraPluginMock();
      MyCobraPluginPlatform.instance = myCobraPluginPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await MyCobraPluginPlatform.instance.getPlatformName(),
          equals(MyCobraPluginMock.mockPlatformName),
        );
      });
    });
  });
}
