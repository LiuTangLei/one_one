import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cobra_plugin/my_cobra_plugin.dart';
import 'package:one_one/counter/counter.dart';
import 'package:one_one/l10n/l10n.dart';
import 'package:one_one/utils/voice_utils.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  PorcupineManager? _porcupineManager;

  @override
  void dispose() {
    _porcupineManager?.stop();
    _porcupineManager?.delete();
    super.dispose();
  }

  Future<void> _startListening() async {
    if (_porcupineManager == null) {
      try {
        _porcupineManager = await createPorcupineManager((keywordIndex) {
          print('Wake word detected: $keywordIndex');
          // 这里可以根据keywordIndex做更多事情，比如更新UI或状态
        });
        await _porcupineManager!.start();
        print('started');
      } catch (e) {
        print('Error creating Porcupine Manager: $e');
      }
    } else {
      await _porcupineManager!.start();
    }
  }

  Future<void> _stopListening() async {
    await _porcupineManager?.stop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    var platformName = '';

    return BlocProvider(
      create: (_) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startListening,
                child: Text('开始测试'),
              ),
              ElevatedButton(
                onPressed: _stopListening,
                child: Text('停止测试'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!context.mounted) return;
                  try {
                    final result = await getPlatformName();
                    setState(() => platformName = result);
                  } catch (error) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).primaryColor,
                        content: Text('$error'),
                      ),
                    );
                  }
                },
                child: const Text('Get Platform Name'),
              ),
              Text(
                'Platform Name: $platformName',
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
