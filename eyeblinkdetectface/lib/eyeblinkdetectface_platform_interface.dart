import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'eyeblinkdetectface_method_channel.dart';

abstract class EyeblinkdetectfacePlatform extends PlatformInterface {
  /// Constructs a EyeblinkdetectfacePlatform.
  EyeblinkdetectfacePlatform() : super(token: _token);

  static final Object _token = Object();

  static EyeblinkdetectfacePlatform _instance = MethodChannelEyeblinkdetectface();

  /// The default instance of [EyeblinkdetectfacePlatform] to use.
  ///
  /// Defaults to [MethodChannelEyeblinkdetectface].
  static EyeblinkdetectfacePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EyeblinkdetectfacePlatform] when
  /// they register themselves.
  static set instance(EyeblinkdetectfacePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
