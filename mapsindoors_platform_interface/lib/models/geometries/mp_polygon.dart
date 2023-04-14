part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// [MPPolygon] is a collection of [MPPoint]s that combine
/// to form a single geographical area with a single body
class MPPolygon extends MPGeometry {
  List<List<List<num>>> _coordinates = List.empty(growable: true);
  List<num> _bbox =
      List.empty(growable: true); // 0 = Lng W, 1 = Lat S, 2 = Lng E, 3 = Lat N
  num? _area;
  List<List<MPPoint>>? _points;
  MPBounds? _bounds;

  /// Create a empty [MPPolygon], remember to set [coordinates] for proper use
  MPPolygon();

  /// Attempts to build a [MPPolygon] from a JSON object, this method will decode the object if needed
  static MPPolygon? fromJson(json) => json != null && json != "null"
      ? MPPolygon._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPPolygon._fromJson(data) {
    // iOS will send an array directly, so handle this case
    if (data is List)
      coordinates = convertJson3dArray<num>(data);
    else {
      coordinates = convertJson3dArray<num>(data["coordinates"]);
      bbox = convertJsonArray<num>(data['bbox']);
    }
  }

  MPPolygon._fromCoordinates(List<List<List<num>>> list) {
    _coordinates = List.from(list);
    var bounds = _calcBounds();
    bbox = [
      bounds.southwest.longitude,
      bounds.southwest.latitude,
      bounds.northeast.longitude,
      bounds.northeast.latitude
    ];
  }

  /// Update the coordinates list for the polygon, the coordinates must be in
  /// [GeoJSON format](https://stevage.github.io/geojson-spec/#section-3.1.6)
  set coordinates(List<List<List<num>>> coordinates) {
    _coordinates = coordinates;
    _clearCache();
  }

  /// Get the coordinates as a collection in [GeoJSON format](https://stevage.github.io/geojson-spec/#section-3.1.6)
  List<List<List<num>>> get coordinates => _coordinates;

  /// Update the polygon' bounding box, the bounding box must be in [GeoJSON format](https://stevage.github.io/geojson-spec/#section-5)
  set bbox(List<num> box) {
    _bbox = box;
    _clearCache();
  }

  /// Get the polygon' bounding box, the bounding box is in [GeoJSON format](https://stevage.github.io/geojson-spec/#section-5)
  List<num> get bbox => _bbox;

  /// Get the [points] the polygon consists of in [GeoJSON format](https://stevage.github.io/geojson-spec/#section-3.1.3)
  List<List<MPPoint>> get points => _points ??= _calcPoints();

  List<List<MPPoint>> _calcPoints() {
    List<List<MPPoint>> points = List.empty(growable: true);
    for (var coordSet in coordinates) {
      List<MPPoint> pointsList = List.empty(growable: true);
      for (var pair in coordSet) {
        pointsList.add(MPPoint.withCoordinates(
            latitude: pair[MPGeometry._lat], longitude: pair[MPGeometry._lng]));
      }
      points.add(pointsList);
    }
    return points;
  }

  /// Get the polygon' bounds. If [bbox] is present then that will be used, otherwise a [MPBounds]
  /// will be created from the coordinates of the polygon
  MPBounds get bounds => _bounds ??= _calcBounds();

  MPBounds _calcBounds() {
    if (bbox.isNotEmpty) {
      return MPBounds(
          northeast:
              MPPoint.withCoordinates(latitude: bbox[3], longitude: bbox[2]),
          southwest:
              MPPoint.withCoordinates(latitude: bbox[1], longitude: bbox[0]));
    } else {
      MPBoundsBuilder builder = MPBounds.builder();
      for (var p in coordinates[0]) {
        builder.include(MPPoint.withCoordinates(
            latitude: p[MPGeometry._lat], longitude: p[MPGeometry._lng]));
      }
      return builder.build();
    }
  }

  /// Calculates the squared distance from the [point] to the closest edge in the polygon
  Future<num?> getSquaredDistanceToClosestEdge(MPPoint point) async =>
      await UtilPlatform.instance
          .geometryGetSquaredDistanceToClosestEdge(this, point);

  /// Get the polygon' area
  @override
  Future<num?> get area async =>
      _area ??= await UtilPlatform.instance.geometryArea(this);

  /// Used to determine the proper type of a [MPGeometry]
  @override
  String get type => MPGeometry.polygon;

  /// Converts the [MPPolygon] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() =>
      {"coordinates": coordinates, "bbox": bbox, "type": type};

  void _clearCache() {
    _area = null;
    _points = null;
    _bounds = null;
  }

  /// Get the [position] of the polygon, which is roughly the center
  @override
  MPPoint get position => bounds.center;
}
