import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class AmbientGlowLayer extends StatelessWidget {
  final ui.Image? image;
  final double radius;
  final BorderRadius borderRadius;

  const AmbientGlowLayer({
    super.key,
    required this.image,
    required this.radius,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null) return const SizedBox.shrink();

    final spreadRadius = radius * 2.0;

    return Positioned(
      top: -spreadRadius,
      left: -spreadRadius,
      right: -spreadRadius,
      bottom: -spreadRadius,
      child: IgnorePointer(
        child: ImageFiltered(
          imageFilter: ui.ImageFilter.blur(
            sigmaX: radius,
            sigmaY: radius,
            tileMode: ui.TileMode.decal,
          ),
          child: _GlowContent(
            image: image!,
            margin: spreadRadius,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}

class _GlowContent extends StatelessWidget {
  final ui.Image image;
  final double margin;
  final BorderRadius borderRadius;

  const _GlowContent({
    required this.image,
    required this.margin,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        1.5, 0, 0, 0, 0,
        0, 1.5, 0, 0, 0,
        0, 0, 1.5, 0, 0,
        0, 0, 0, 1.0, 0,
      ]),
      child: Container(
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(borderRadius: borderRadius),
        clipBehavior: Clip.antiAlias,
        child: Transform.scale(
          scale: 1.1,
          child: RawImage(
            image: image,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.low,
          ),
        ),
      ),
    );
  }
}
