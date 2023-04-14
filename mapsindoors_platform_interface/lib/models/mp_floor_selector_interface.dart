part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Interface used by MapsIndoors to communicate with floor selector UIs
abstract class MPFloorSelectorInterface {
  /// A floor selector must be a [Widget]
  Widget? getWidget();
  /// Update the floors shown in the selector
  void setFloors(List<MPFloor>? floors);
  /// Set a listener that listens for when a floor is selected in the floor selector
  /// 
  /// NB: This is used internally in the SDK, overwriting the listener will result in functionality loss
  void setOnFloorSelectionChangedListener(
      OnFloorSelectionChangedListener listener);
  /// Show/Hide the floor selector, this is called when a building comes into/out of view
  void show(bool show);
  /// Invoked when a floor has been selected programmatically
  void setSelectedFloor(MPFloor floor);
  /// Invoked when a floor has been selected programmatically by index
  void setSelectedFloorByFloorIndex(int floorIndex);
  /// Invoked when the zoom level changes
  void zoomLevelChanged(num newZoomLevel);
  /// Whether to allow the floor to automatically change, eg. when panning to a new building
  bool isAutoFloorChangeEnabled();
  /// Invoked when user positioning changes [floorIndex]
  void setUserPositionFloor(int floorIndex);
}
