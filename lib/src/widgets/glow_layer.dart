import 'package:flutter/material.dart';
import '../enums/led_mode.dart';

class GlowLayer extends StatelessWidget {
  final double animationValue;
  final double radius;
  final BorderRadius borderRadius;
  final Color color;
  final LedMode mode;

  const GlowLayer({
    super.key,
    required this.animationValue,
    required this.radius,
    required this.borderRadius,
    required this.color,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: _getEffectiveColor().withAlpha(153),
                blurRadius: radius,
                spreadRadius: radius * 0.15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getEffectiveColor() {
    if (mode == LedMode.staticColor) return color;
    
    // Default dynamic behavior (Rainbow)
    return HSVColor.fromAHSV(
      1.0,
      animationValue * 360,
      1.0,
      1.0,
    ).toColor();
  }
}
