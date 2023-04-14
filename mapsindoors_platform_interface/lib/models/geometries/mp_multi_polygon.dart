part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// [MPMultiPolygon] is a collection of [MPPolygon]s that combine 
/// to form a single geographical area with multiple bodies
class MPMultiPolygon extends MPGeometry {
  List<List<List<List<num>>>> _coordinates = List.empty(growable: true);
  List<num> _bbox =
      List.empty(growable: true); // 0 = Lng W, 1 = Lat S, 2 = Lng E, 3 = Lat N
  num? _area;
  MPBounds? _bounds;

  /// Create a empty [MPMultiPolygon], remember to set [coordinates] for proper use
  MPMultiPolygon();

  /// Attempts to build a [MPMultiPolygon] from a JSON object, this method will decode the object if needed
  static MPMultiPolygon? fromJson(json) => json != null && json != "null"
      ? MPMultiPolygon._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPMultiPolygon._fromJson(data) {
    coordinates = convertJson4dArray<num>(data['coordinates']);
    bbox = convertJsonArray<num>(data['bbox']);
  }

  /// Update the coordinates list for the polygon, the coordinates must be in 
  /// [GeoJSON format](https://stevage.github.io/geojson-spec/#section-3.1.7)
  set coordinates(List<List<List<List<num>>>> coordinates) {
    _coordinates = coordinates;
    _clearCache();
  }

  /// Get the coordinates as a collection in [GeoJSON format](https://stevage.github.io/geojson-spec/#section-3.1.7)
  List<List<List<List<num>>>> get coordinates => _coordinates;

  /// Update the polygon's bounding box, the bounding box must be in [GeoJson format](https://stevage.github.io/geojson-spec/#section-5)
  set bbox(List<num> box) {
    _bbox = box;
    _clearCache();
  }

  /// Get the polygon's bounding box, the bounding box is in [GeoJson format](https://stevage.github.io/geojson-spec/#section-5)
  List<num> get bbox => _bbox;

  /// Get the polygon's bounds. If [bbox] is present then that will be used, otherwise a [MPBounds] 
  /// will be created from the coordinates of the polygon
  MPBounds get bounds => _bounds ??= _calcBounds();

  MPBounds _calcBounds() {
    if (bbox.isNotEmpty) {
      return MPBounds(northeast: MPPoint.withCoordinates(latitude: bbox[3], longitude: bbox[2]),
                      southwest: MPPoint.withCoordinates(latitude: bbox[1], longitude: bbox[0]));
    } else {
      MPBoundsBuilder builder = MPBounds.builder();
      for (var p in coordinates) {
        for (var outline in p[0]) {
          builder.include(MPPoint.withCoordinates(
              latitude: outline[MPGeometry._lat], longitude: outline[MPGeometry._lng]));
        }
      }
      return builder.build();
    }
  }

  /// Calculates the squared distance from the [point] to the closest edge in the polygon
  Future<num?> getSquaredDistanceToClosestEdge(MPPoint point) async =>
      await UtilPlatform.instance
          .geometryGetSquaredDistanceToClosestEdge(this, point);

  /// Converts the [MPMultiPolygon] to a collection of [MPPolygon]s
  List<MPPolygon> toMPPolygons() {
    List<MPPolygon> result = List.empty(growable: true);
    for (var coordinate in _coordinates) {
      result.add(MPPolygon._fromCoordinates(coordinate));
    }
    return result;
  }

  /// Get the polygon's area, this is the combined area of all the polygons in the [MPMultiPolygon]
  @override
  Future<num?> get area async =>
      _area ??= await UtilPlatform.instance.geometryArea(this);

  /// Used to determine the proper type of a [MPGeometry]
  @override
  String get type => MPGeometry.multiPolygon;

  /// Converts the [MPMultiPolygon] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() =>
      {"coordinates": coordinates, "bbox": bbox, "type": type};

  void _clearCache() {
    _area = null;
    _bounds = null;
  }

  /// Get the [position] of the polygon, which is roughly the center
  @override
  MPPoint get position => bounds.center;
}
