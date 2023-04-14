part of 'package:mapsindoors_platform_interface/platform_library.dart';

abstract class DirectionsRendererPlatform extends PlatformInterface {
  DirectionsRendererPlatform() : super(token: _token);

  static final Object _token = Object();

  static DirectionsRendererPlatform _instance =
      MethodChannelDirectionsRenderer();

  static DirectionsRendererPlatform get instance => _instance;

  static set instance(DirectionsRendererPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> clear();

  Future<int?> getSelectedLegFloorIndex();

  Future<void> nextLeg();

  Future<void> previousLeg();

  Future<void> selectLegIndex(int legIndex);

  Future<void> setAnimatedPolyline(
      bool animated, bool repeating, int durationMs);

  Future<void> setCameraAnimationDuration(int durationMs);

  Future<void> setCameraViewFitMode(MPCameraViewFitMode mpCameraViewFitMode);

  Future<void> setOnLegSelectedListener(
      OnLegSelectedListener? onLegSelectedListener);

  Future<void> setPolyLineColors(String foreground, String background);

  Future<void> setRoute(MPRoute? route);

  Future<void> useContentOfNearbyLocations();
}
