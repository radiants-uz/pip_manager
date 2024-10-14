import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:pip_manager/pip_manager_platform_interface.dart';

class MethodChannelPiPManager extends PiPManagerPlatform {
  static const MethodChannel _channel = MethodChannel('pip_manager');
  static const EventChannel _eventChannel = EventChannel('pip_manager/events');

  @override
  Future<void> startPictureInPictureMode(String? videoUrl) async {
    try {
      await _channel.invokeMethod(
          'startPiP', videoUrl != null ? {'url': videoUrl} : null);
    } on PlatformException catch (e) {
      log('Failed to start PiP: ${e.message}');
    }
  }

  @override
  Stream<int?> get onPipDisabled {
    // Use the EventChannel to receive stream events
    return _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event as int?);
  }
}
