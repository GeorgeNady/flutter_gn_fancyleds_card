import 'dart:ui';

import 'package:flutter/material.dart';

class GlowLayer extends StatelessWidget {
  final double animationValue;
  final double radius;
  final BorderRadius borderRadius;

  const GlowLayer({
    super.key,
    required this.animationValue,
    required this.radius,
    required this.borderRadius,
  });

  Color _color(double t) {
    return HSVColor.fromAHSV(
      1,
      t * 360,
      1,
      1,
    ).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(animationValue);

    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(.6),
                blurRadius: radius,
                spreadRadius: radius * .15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}