part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when user positioning is updated
abstract class OnPositionUpdateListener {
  /// When a new [position] is provided
  void onPositionUpdate(MPPositionResultInterface position);
}
