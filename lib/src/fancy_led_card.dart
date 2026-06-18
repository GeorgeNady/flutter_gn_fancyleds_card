import 'package:flutter/material.dart';

import 'led_mode.dart';
import 'widgets/animated_led_border.dart';
import 'widgets/glow_layer.dart';

class FancyLedCard extends StatefulWidget {
  final Widget child;
  final LedMode mode;
  final double borderWidth;
  final double glowRadius;
  final BorderRadius borderRadius;

  const FancyLedCard({
    super.key,
    required this.child,
    this.mode = LedMode.rainbow,
    this.borderWidth = 2,
    this.glowRadius = 40,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(24),
    ),
  });

  @override
  State<FancyLedCard> createState() => _FancyLedCardState();
}

class _FancyLedCardState extends State<FancyLedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            GlowLayer(
              animationValue: controller.value,
              radius: widget.glowRadius,
              borderRadius: widget.borderRadius,
            ),
            AnimatedLedBorder(
              animationValue: controller.value,
              borderWidth: widget.borderWidth,
              borderRadius: widget.borderRadius,
              child: widget.child,
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}