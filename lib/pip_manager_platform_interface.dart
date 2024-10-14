import 'package:pip_manager/pip_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class PiPManagerPlatform extends PlatformInterface {
  PiPManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static PiPManagerPlatform _instance = MethodChannelPiPManager();

  static PiPManagerPlatform get instance => _instance;

  static set instance(PiPManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Method to be implemented by platform-specific code to start PiP mode
  Future<void> startPictureInPictureMode(String? videoUrl) {
    throw UnimplementedError(
        'startPictureInPictureMode() has not been implemented.');
  }

  // Method to listen for PiP disabled events
  Stream<int?> get onPipDisabled {
    throw UnimplementedError('onPipDisabled has not been implemented.');
  }
}
