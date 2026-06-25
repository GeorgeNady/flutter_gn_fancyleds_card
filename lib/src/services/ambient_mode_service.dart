import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/led_frame.dart';
import '../utils/hardware_health_utils.dart';
import '../utils/image_processor_utils.dart';

/// Interface for the hardware driver that actually communicates with the LED card.
abstract class LedHardwareDriver {
  Future<void> sendFrame(LedFrame frame);
  Stream<bool> get connectionStatus;
}

/// The core service responsible for managing the Ambient Mode loop.
class AmbientModeService {
  final LedHardwareDriver driver;
  final HardwareHealthUtils healthUtils;
  final int targetWidth;
  final int targetHeight;

  StreamSubscription<Uint8List>? _frameSubscription;
  bool _isProcessing = false;

  AmbientModeService({
    required this.driver,
    required this.healthUtils,
    required this.targetWidth,
    required this.targetHeight,
  });

  /// Starts the ambient mode processing loop from a stream of image bytes.
  void start(Stream<Uint8List> frameStream) {
    _frameSubscription = frameStream.listen((bytes) async {
      if (_isProcessing || healthUtils.isDeviceUnresponsive) {
        return; // Skip if already processing or device is dead
      }

      _isProcessing = true;
      try {
        // Use compute to run the heavy image processing in a separate Isolate.
        final LedFrame processedFrame = await compute(
          _processFrameWrapper,
          _ProcessParams(bytes, targetWidth, targetHeight),
        );

        // Send the frame to the hardware driver.
        await driver.sendFrame(processedFrame);
        
        // Record success for health monitoring.
        healthUtils.recordSuccess();
      } catch (e) {
        debugPrint("Error in AmbientModeService: $e");
      } finally {
        _isProcessing = false;
      }
    });
  }

  /// Stops the ambient mode processing loop.
  void stop() {
    _frameSubscription?.cancel();
    _frameSubscription = null;
  }

  /// Internal wrapper for the compute function (must be top-level or static).
  static LedFrame _processFrameWrapper(_ProcessParams params) {
    return ImageProcessorUtils.processFrame(
      params.bytes,
      params.width,
      params.height,
    );
  }
}

/// Helper class to pass multiple arguments to the compute function.
class _ProcessParams {
  final Uint8List bytes;
  final int width;
  final int height;

  _ProcessParams(this.bytes, this.width, this.height);
}
