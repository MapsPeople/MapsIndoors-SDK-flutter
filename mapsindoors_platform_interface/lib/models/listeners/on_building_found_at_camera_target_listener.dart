part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when a building is found within the camera bounds
abstract class OnBuildingFoundAtCameraTargetListener {
  /// When a [building] is found
  void onBuildingFoundAtCameraTarget(MPBuilding? building);
}