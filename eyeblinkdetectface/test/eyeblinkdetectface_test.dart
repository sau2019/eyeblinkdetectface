import 'package:flutter_test/flutter_test.dart';
import 'package:eyeblinkdetectface/eyeblinkdetectface_platform_interface.dart';
import 'package:eyeblinkdetectface/eyeblinkdetectface_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEyeblinkdetectfacePlatform
    with MockPlatformInterfaceMixin
    implements EyeblinkdetectfacePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EyeblinkdetectfacePlatform initialPlatform =
      EyeblinkdetectfacePlatform.instance;

  test('$MethodChannelEyeblinkdetectface is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEyeblinkdetectface>());
  });
}
