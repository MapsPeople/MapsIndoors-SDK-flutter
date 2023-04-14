part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An implementation of [UtilPlatform] that uses method channels.
class MethodChannelUtil extends UtilPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final utilMethodChannel = const MethodChannel('UtilMethodChannel');

  @override
  Future<String?> getPlatformVersion() async {
    return await utilMethodChannel.invokeMethod<String>('UTL_getPlatformVersion');
  }

  @override
  Future<bool?> venueHasGraph(String venueId) async {
    return await utilMethodChannel.invokeMethod<bool>('UTL_venueHasGraph', {"id":venueId});
  }

  @override
  Future<num?> pointAngleBetween(MPPoint it, MPPoint other) async {
    return await utilMethodChannel.invokeMethod<num>("UTL_pointAngleBetween",
        {"it": it._jsonEncode(), "other": other._jsonEncode()});
  }

  @override
  Future<num?> pointDistanceTo(MPPoint it, MPPoint other) async {
    return await utilMethodChannel.invokeMethod<num>("UTL_pointDistanceTo",
        {"it": it._jsonEncode(), "other": other._jsonEncode()});
  }

  @override
  Future<bool?> geometryIsInside(MPGeometry it, MPPoint point) async {
    return await utilMethodChannel.invokeMethod<bool>("UTL_geometryIsInside",
        {"it": it._jsonEncode(), "point": point._jsonEncode()});
  }

  @override
  Future<num?> geometryArea(MPGeometry it) async {
    return await utilMethodChannel.invokeMethod<num>(
        "UTL_geometryArea", {"geometry":it._jsonEncode()});
  }

  @override
  Future<num?> geometryGetSquaredDistanceToClosestEdge(
      MPGeometry it, MPPoint point) async {
    return await utilMethodChannel.invokeMethod<num>(
        "UTL_polygonDistToClosestEdge",
        {"it": it._jsonEncode(), "point": point._jsonEncode()});
  }
  
  @override
  Future<String?> parseMapClientUrl(String venueId, String locationId) async {
    return await utilMethodChannel.invokeMethod(
        "UTL_parseMapClientUrl", {"venueId": venueId, "locationId": locationId});
  }

  @override
  Future<void> setCollisionHandling(MPCollisionHandling handling) async {
    return await utilMethodChannel.invokeMethod(
        "UTL_setCollisionHandling", {"handling":handling.value});
  }

  @override
  Future<void> setEnableClustering(bool enable) async {
    return await utilMethodChannel.invokeMethod(
        "UTL_setEnableClustering", {"enable":enable});
  }

  @override
  Future<void> setExtrusionOpacity(num opacity) async {
    return await utilMethodChannel.invokeMethod(
        "UTL_setExtrusionOpacity", {"opacity":opacity});
  }

  @override
  Future<void> setWallOpacity(num opacity) async {
    return await utilMethodChannel.invokeMethod(
        "UTL_setWallOpacity", {"opacity":opacity});
  }
}
