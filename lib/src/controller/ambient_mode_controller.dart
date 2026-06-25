import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/ambient_mode_service.dart';
import '../utils/hardware_health_utils.dart';

/// Controller to manage the Ambient Mode from the UI layer.
class AmbientModeController extends ChangeNotifier {
  final AmbientModeService _service;
  final HardwareHealthUtils _healthUtils;

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  bool get isHardwareHealthy => _healthUtils.isHealthy;

  AmbientModeController({
    required AmbientModeService service,
    required HardwareHealthUtils healthUtils,
  })  : _service = service,
        _healthUtils = healthUtils;

  /// Starts the ambient mode with a stream of image bytes.
  void start(Stream<Uint8List> frameStream) {
    if (_isRunning) return;
    
    _isRunning = true;
    _service.start(frameStream);
    notifyListeners();
  }

  /// Stops the ambient mode.
  void stop() {
    if (!_isRunning) return;

    _service.stop();
    _isRunning = false;
    notifyListeners();
  }

  /// Manually trigger a health check or reset.
  void resetHealth() {
    _healthUtils.reset();
    notifyListeners();
  }
}
