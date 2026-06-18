import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

/// Interface for image processing strategies (Dependency Inversion Principle).
abstract class IImageProcessor {
  Future<AmbientData> process(RenderRepaintBoundary boundary);
}

/// Data class holding processed ambient information.
class AmbientData {
  final ui.Image image;
  final List<ui.Color> sampledColors;

  AmbientData({required this.image, required this.sampledColors});

  void dispose() {
    image.dispose();
  }
}

/// Implementation of Ambilight-style processing (Single Responsibility Principle).
class AmbilightProcessor implements IImageProcessor {
  @override
  Future<AmbientData> process(RenderRepaintBoundary boundary) async {
    final image = await boundary.toImage(pixelRatio: 1.0);
    final sampledColors = await _extractPerimeterColors(image);
    return AmbientData(image: image, sampledColors: sampledColors);
  }

  Future<List<ui.Color>> _extractPerimeterColors(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) return [];

    final bytes = byteData.buffer.asUint8List();
    final width = image.width;
    final height = image.height;

    // Sampling 8 perimeter points
    final points = [
      ui.Offset(0, 0), ui.Offset(width / 2, 0), ui.Offset(width - 1, 0),
      ui.Offset(width - 1, height / 2), ui.Offset(width - 1, height - 1),
      ui.Offset(width / 2, height - 1), ui.Offset(0, height - 1),
      ui.Offset(0, height / 2),
    ];

    return points.map((pos) {
      final x = pos.dx.toInt().clamp(0, width - 1);
      final y = pos.dy.toInt().clamp(0, height - 1);
      final offset = (y * width + x) * 4;
      return ui.Color.fromARGB(
        bytes[offset + 3], bytes[offset], bytes[offset + 1], bytes[offset + 2],
      );
    }).toList();
  }
}
