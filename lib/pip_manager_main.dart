import 'package:pip_manager/pip_manager_platform_interface.dart';

class PiPManager {
  // Expose the platform-specific implementation via the platform interface
  static Future<void> startPictureInPictureMode([String? videoUrl]) {
    return PiPManagerPlatform.instance.startPictureInPictureMode(videoUrl);
  }

  // Listen for PiP disabled events
  static Stream<int?> get onPipDisabled {
    return PiPManagerPlatform.instance.onPipDisabled;
  }
}
