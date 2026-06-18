import 'package:flutter/material.dart';
import '../enums/led_mode.dart';

class AnimatedLedBorder extends StatelessWidget {
  final Widget child;
  final double animationValue;
  final double borderWidth;
  final BorderRadius borderRadius;
  final GlobalKey? boundaryKey;
  final Color color;
  final LedMode mode;
  final List<Color> sampledColors;

  const AnimatedLedBorder({
    super.key,
    required this.child,
    required this.animationValue,
    required this.borderWidth,
    required this.borderRadius,
    this.boundaryKey,
    required this.color,
    required this.mode,
    this.sampledColors = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildDecoration(),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: RepaintBoundary(
            key: boundaryKey,
            child: child,
          ),
        ),
      ),
    );
  }

  Decoration _buildDecoration() {
    switch (mode) {
      case LedMode.ambient:
        return _buildAmbientDecoration();
      case LedMode.staticColor:
        return _buildStaticDecoration();
      default:
        return _buildAnimatedDecoration();
    }
  }

  Decoration _buildAmbientDecoration() {
    return BoxDecoration(
      borderRadius: borderRadius,
      gradient: sampledColors.length >= 8
          ? SweepGradient(colors: [...sampledColors, sampledColors.first])
          : null,
      color: sampledColors.isEmpty ? Colors.black.withAlpha(204) : null,
    );
  }

  Decoration _buildStaticDecoration() {
    return BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(color: color, width: borderWidth),
    );
  }

  Decoration _buildAnimatedDecoration() {
    return BoxDecoration(
      borderRadius: borderRadius,
      gradient: SweepGradient(
        transform: GradientRotation(animationValue * 6.28),
        colors: const [
          Colors.red, Colors.orange, Colors.yellow, Colors.green,
          Colors.cyan, Colors.blue, Colors.purple, Colors.red,
        ],
      ),
    );
  }
}
