import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eyeblinkdetectface/eyeblinkdetectface_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelEyeblinkdetectface platform = MethodChannelEyeblinkdetectface();
  const MethodChannel channel = MethodChannel('eyeblinkdetectface');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
