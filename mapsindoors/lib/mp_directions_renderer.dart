part of 'package:mapsindoors/mapsindoors.dart';

class MPDirectionsRenderer {
  /// Set a route to be rendered. This also resets the selected leg and step indices to 0.
  Future<void> setRoute(MPRoute? route) =>
    DirectionsRendererPlatform.instance.setRoute(route);

  /// Clears the route from the map
  Future<void> clear() =>
    DirectionsRendererPlatform.instance.clear();

  /// Selects the next leg if possible.
  /// 
  /// Has no effect if the last leg is selected
  Future<void> nextLeg() =>
    DirectionsRendererPlatform.instance.nextLeg();

  /// Selects the previous leg if possible.
  /// 
  /// Has no effect if the first leg is selected
  Future<void> previousLeg() =>
    DirectionsRendererPlatform.instance.previousLeg();

  /// Enable/Disable the polyline animation when displaying a route element on the map
  Future<void> setAnimatedPolyline(bool animated, bool repeating, int durationMs) =>
    DirectionsRendererPlatform.instance
        .setAnimatedPolyline(animated, repeating, durationMs);

  /// Set the colors of the polyline
  Future<void> setPolyLineColors(String foreground, String background) =>
    DirectionsRendererPlatform.instance
        .setPolyLineColors(foreground, background);

  /// Manually set the selected leg index on the route.
  /// 
  /// This may throw an exception if the resulting internal state is invalid (parsed index is out of bounds)
  Future<void> selectLegIndex(int legIndex) =>
    DirectionsRendererPlatform.instance.selectLegIndex(legIndex);

  /// Gets the currently selected leg's floor index.
  Future<int?> getSelectedLegFloorIndex() =>
    DirectionsRendererPlatform.instance.getSelectedLegFloorIndex();

  /// Set the duration of camera animations (ms).
  /// 
  /// If a duration &#60; 0 then camera animations are disabled, and the camera will move instantly.
  /// 
  /// The value is 1000 ms by default
  Future<void> setCameraAnimationDuration(int durationMs) =>
    DirectionsRendererPlatform.instance.setCameraAnimationDuration(durationMs);

  /// Set the [MPCameraViewFitMode] of the camera, when displaying route elements on the map.
  /// 
  /// The camera may be aligned to north, aligned with the first step, or aligned from
  /// start point to end point.
  Future<void> setCameraViewFitMode(MPCameraViewFitMode mpCameraViewFitMode) =>
    DirectionsRendererPlatform.instance.setCameraViewFitMode(mpCameraViewFitMode);

  /// Set a listener, which will be invoked when a new leg has been selected
  /// 
  /// This is used for when the forward/back markers are selected on the map
  Future<void> setOnLegSelectedListener(OnLegSelectedListener? onLegSelectedListener) =>
    DirectionsRendererPlatform.instance.setOnLegSelectedListener(onLegSelectedListener);
}
