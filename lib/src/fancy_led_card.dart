import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'enums/led_mode.dart';
import 'controller/fancy_led_controller.dart';
import 'services/ambient_processor.dart';
import 'widgets/ambient_glow_layer.dart';
import 'widgets/animated_led_border.dart';
import 'widgets/glow_layer.dart';

class FancyLedCard extends StatefulWidget {
  final Widget child;
  final LedMode mode;
  final double borderWidth;
  final double glowRadius;
  final BorderRadius borderRadius;
  final FancyLedController? controller;
  final Color? color;
  final IImageProcessor? processor;

  const FancyLedCard({
    super.key,
    required this.child,
    this.mode = LedMode.rainbow,
    this.borderWidth = 2,
    this.glowRadius = 40,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.controller,
    this.color,
    this.processor,
  });

  @override
  State<FancyLedCard> createState() => _FancyLedCardState();
}

class _FancyLedCardState extends State<FancyLedCard> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final GlobalKey _boundaryKey = GlobalKey();
  
  AmbientData? _ambientData;
  late final IImageProcessor _processor;

  @override
  void initState() {
    super.initState();
    _processor = widget.processor ?? AmbilightProcessor();
    _initAnimation();
    _setupController();
    _requestAmbientUpdate();
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  void _setupController() {
    widget.controller?.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(covariant FancyLedCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      widget.controller?.addListener(_onControllerChanged);
    }

    if (widget.mode == LedMode.ambient && _shouldUpdateAmbient(oldWidget)) {
      _requestAmbientUpdate();
    }
  }

  bool _shouldUpdateAmbient(FancyLedCard oldWidget) {
    return oldWidget.child != widget.child || oldWidget.mode != widget.mode;
  }

  void _onControllerChanged() {
    if (widget.mode == LedMode.ambient) {
      _requestAmbientUpdate();
    } else {
      setState(() {});
    }
  }

  void _requestAmbientUpdate() {
    if (widget.mode != LedMode.ambient) return;
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final boundary = _boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      final data = await _processor.process(boundary);
      if (mounted) {
        setState(() {
          _ambientData?.dispose();
          _ambientData = data;
        });
      }
    });
  }

  Color get _activeColor {
    return widget.color ?? widget.controller?.color ?? Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = _activeColor;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            _buildGlowLayer(activeColor),
            _buildBorder(activeColor),
          ],
        );
      },
    );
  }

  Widget _buildGlowLayer(Color color) {
    if (widget.mode == LedMode.ambient) {
      return AmbientGlowLayer(
        image: _ambientData?.image,
        radius: widget.glowRadius,
        borderRadius: widget.borderRadius,
      );
    }
    return GlowLayer(
      animationValue: _animationController.value,
      radius: widget.glowRadius,
      borderRadius: widget.borderRadius,
      color: color,
      mode: widget.mode,
    );
  }

  Widget _buildBorder(Color color) {
    return AnimatedLedBorder(
      animationValue: _animationController.value,
      borderWidth: widget.borderWidth,
      borderRadius: widget.borderRadius,
      boundaryKey: _boundaryKey,
      color: color,
      mode: widget.mode,
      sampledColors: _ambientData?.sampledColors ?? [],
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
    _animationController.dispose();
    _ambientData?.dispose();
    super.dispose();
  }
}
