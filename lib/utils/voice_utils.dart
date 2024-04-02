import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';

typedef WakeWordCallback = void Function(int keywordIndex);

Future<PorcupineManager> createPorcupineManager(
    WakeWordCallback wakeWordCallback) async {
  final accessKey = dotenv.env['ACCESS_KEY'] ?? '';
  String keywordAsset;
  if (Platform.isAndroid) {
    keywordAsset = 'assets/one-one-android.ppn';
  } else if (Platform.isIOS) {
    keywordAsset = 'assets/one-one-ios.ppn';
  } else {
    keywordAsset = 'assets/one-one-android.ppn';
  }
  try {
    final porcupineManager = await PorcupineManager.fromKeywordPaths(
      accessKey,
      [keywordAsset],
      wakeWordCallback,
    );
    return porcupineManager;
  } on PorcupineException catch (err) {
    print('Error initializing Porcupine: $err');
    throw err;
  }
}
