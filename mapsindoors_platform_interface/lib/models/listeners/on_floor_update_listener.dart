part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when floor selection changes
abstract class OnFloorUpdateListener {
  /// When the current [floor] changes, this might be due to a [building]
  void onFloorUpdate(int floor);
}