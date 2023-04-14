part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when the active floor is changed
abstract class OnFloorSelectionChangedListener {
  /// When the floor selection is changed to a [newFloor]
  void onFloorSelectionChanged(MPFloor newFloor);
}