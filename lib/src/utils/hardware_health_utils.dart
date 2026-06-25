import 'dart:async';

/// Utility to monitor the responsiveness of the LED hardware.
/// Helps prevent unnecessary calculations when the connection is lost or lagging.
class HardwareHealthUtils {
  final Duration timeoutThreshold;
  DateTime? _lastResponseTime;

  HardwareHealthUtils({this.timeoutThreshold = const Duration(seconds: 2)});

  /// Updates the last known successful communication time.
  /// Call this whenever a command is successfully acknowledged by the hardware.
  void recordSuccess() {
    _lastResponseTime = DateTime.now();
  }

  /// Returns true if the device has not responded within the threshold.
  bool get isDeviceUnresponsive {
    if (_lastResponseTime == null) return true;
    return DateTime.now().difference(_lastResponseTime!) > timeoutThreshold;
  }

  /// Resets the health status.
  void reset() {
    _lastResponseTime = DateTime.now();
  }

  /// Returns true if the device is considered healthy.
  bool get isHealthy => !isDeviceUnresponsive;
}
