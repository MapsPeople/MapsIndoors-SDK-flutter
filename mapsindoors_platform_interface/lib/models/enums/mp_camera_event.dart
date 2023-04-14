part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Possible events that a [MPCameraEventListener] can recieve
enum MPCameraEvent {
  finished,
  cancelled,
  moveStartedApiAnimation,
  moveStartedDeveloperAnimation,
  moveStartedGesture,
  onMove,
  moveCancelled,
  idle
}
