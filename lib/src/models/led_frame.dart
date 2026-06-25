import 'dart:typed_data';

/// Represents a single frame of data to be sent to the LED hardware.
/// Uses [Uint32List] for high-performance color storage (ARGB format).
class LedFrame {
  final int width;
  final int height;
  final Uint32List pixels;

  LedFrame({
    required this.width,
    required this.height,
    required this.pixels,
  });

  /// Checks if the frame size matches the expected dimensions.
  bool get isValid => pixels.length == width * height;
}
