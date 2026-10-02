import 'package:ap1_trainer/core/util/haptics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final calls = <MethodCall>[];

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          calls.add(call);
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  Future<Object?> argOf(Future<void> Function() f) async {
    calls.clear();
    await f();
    expect(calls, hasLength(1));
    expect(calls.single.method, 'HapticFeedback.vibrate');
    return calls.single.arguments;
  }

  test('AppHaptics nutzt feste Muster', () async {
    expect(await argOf(AppHaptics.select), 'HapticFeedbackType.selectionClick');
    expect(await argOf(AppHaptics.correct), 'HapticFeedbackType.lightImpact');
    expect(await argOf(AppHaptics.wrong), 'HapticFeedbackType.mediumImpact');
    expect(await argOf(AppHaptics.milestone), 'HapticFeedbackType.heavyImpact');
    expect(await argOf(AppHaptics.flip), 'HapticFeedbackType.selectionClick');
  });
}
