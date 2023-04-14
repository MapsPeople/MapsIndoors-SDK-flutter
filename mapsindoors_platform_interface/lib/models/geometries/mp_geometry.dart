part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Superclass of all MapsIndoors geometry classes
abstract class MPGeometry extends MapsIndoorsObject {
  static const _lat = 1;
  static const _lng = 0;
  static const point = "Point";
  static const polygon = "Polygon";
  static const multiPolygon = "MultiPolygon";
  String get type;
  Future<num?> get area;
  MPPoint get position;
  
  /// Check whether a [point] is contained within the geometry
  Future<bool?> contains(MPPoint point) async =>
      await UtilPlatform.instance.geometryIsInside(this, point);
}
