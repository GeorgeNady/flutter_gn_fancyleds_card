import 'package:flutter/material.dart';

class AnimatedLedBorder extends StatelessWidget {
  final Widget child;
  final double animationValue;
  final double borderWidth;
  final BorderRadius borderRadius;
  final GlobalKey? boundaryKey;
  final Color color;
  final List<Color> sampledColors;

  const AnimatedLedBorder({
    super.key,
    required this.child,
    required this.animationValue,
    required this.borderWidth,
    required this.borderRadius,
    this.boundaryKey,
    required this.color,
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
    return BoxDecoration(
      borderRadius: borderRadius,
      gradient: sampledColors.length >= 8
          ? SweepGradient(
              transform: GradientRotation(animationValue * 6.28),
              colors: [...sampledColors, sampledColors.first],
            )
          : null,
      color: sampledColors.isEmpty ? Colors.black.withAlpha(204) : null,
    );
  }
}
