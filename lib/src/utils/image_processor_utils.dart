import 'dart:typed_data';
import 'package:image/image.dart' as img;
import '../models/led_frame.dart';

/// Utility for heavy-duty image processing.
/// Designed to be used within an Isolate to prevent UI jank.
class ImageProcessorUtils {
  /// Processes a raw image byte array and converts it into an [LedFrame].
  /// 
  /// [imageBytes] - The raw bytes of the image (e.g., from a video frame).
  /// [targetWidth] - The width of the LED matrix.
  /// [targetHeight] - The height of the LED matrix.
  /// 
  /// This method performs downsampling and color extraction.
  static LedFrame processFrame(
    Uint8List imageBytes,
    int targetWidth,
    int targetHeight,
  ) {
    // Decode the image from bytes
    final decodedImage = img.decodeImage(imageBytes);
    if (decodedImage == null) {
      throw Exception("Failed to decode image bytes.");
    }

    // Resize the image to match the LED matrix dimensions
    final resizedImage = img.copyResize(
      decodedImage,
      width: targetWidth,
      height: targetHeight,
      interpolation: img.Interpolation.nearest, // Use nearest neighbor for speed
    );

    // Prepare the pixel buffer (ARGB format)
    final pixels = Uint32List(targetWidth * targetHeight);

    for (int y = 0; y < targetHeight; y++) {
      for (int x = 0; x < targetWidth; x++) {
        final pixel = resizedImage.getPixel(x, y);
        
        // Extract components and pack into a single 32-bit integer (ARGB)
        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();
        final a = pixel.a.toInt();

        // Pack as 0xAARRGGBB
        pixels[y * targetWidth + x] = (a << 24) | (r << 16) | (g << 8) | b;
      }
    }

    return LedFrame(
      width: targetWidth,
      height: targetHeight,
      pixels: pixels,
    );
  }
}
