import 'package:flutter/material.dart';

class AnimatedLedBorder extends StatelessWidget {
  final Widget child;
  final double animationValue;
  final double borderWidth;
  final BorderRadius borderRadius;

  const AnimatedLedBorder({
    super.key,
    required this.child,
    required this.animationValue,
    required this.borderWidth,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: SweepGradient(
          transform: GradientRotation(
            animationValue * 6.28,
          ),
          colors: const [
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.cyan,
            Colors.blue,
            Colors.purple,
            Colors.red,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      ),
    );
  }
}