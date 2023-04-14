part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// [MPPoint] is a representation of [latitude] and [longitude] coordinates packaged with
/// a Z-axis representation in [floorIndex]
class MPPoint extends MPGeometry {
  // max int32, same value returned in SDK
  /// The index returned when no floor index has been specified
  ///
  /// == 2147483647
  static const noFloorIndex = 2147483647;
  num? _lat;
  num? _lng;
  int? _floorIndex;

  /// Create a empty [MPPoint], remember to [setCoordinates] for proper use
  MPPoint();

  /// Copy another [MPPoint]'s coordinates
  MPPoint.copy(MPPoint other) {
    _lat = other.latitude;
    _lng = other.longitude;
    _floorIndex = other.floorIndex;
  }

  /// Createa a [MPPoint] from a set of [latitude]/[longitude] coordinates and an optional [floorIndex]
  MPPoint.withCoordinates(
      {required num longitude, required num latitude, int? floorIndex}) {
    _lng = longitude;
    _lat = latitude;
    _floorIndex = floorIndex;
  }

  /// Attempts to build a [MPPoint] from a JSON object, this method will decode the object if needed
  static MPPoint? fromJson(json) => json != null && json != "null"
      ? MPPoint._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPPoint._fromJson(data) {
    // iOS will send an array directly, so handle this case
    final List<num> coordinates;
    if (data is List)
      coordinates = convertJsonArray<num>(data);
    else
      coordinates = convertJsonArray<num>(data["coordinates"]);

    _lng = coordinates[0];
    _lat = coordinates[1];
    if (coordinates.length > 2) {
      _floorIndex = coordinates[2].toInt();
    }
  }

  /// Update both coordinates for the point
  void setCoordinates({required num latitude, required num longitude}) {
    _lng = longitude;
    _lat = latitude;
  }

  /// Set a new [latitude]
  set latitude(num lat) => _lat = lat;

  /// Set a new [longitude]
  set longitude(num lng) => _lng = lng;

  /// Set a new [floorIndex]
  set floorIndex(int floorIndex) => _floorIndex = floorIndex;

  /// Get the [latitude], if none is present returns [double.nan]
  num get latitude => _lat ?? double.nan;

  /// Get the [longitude], if none is present returns [double.nan]
  num get longitude => _lng ?? double.nan;

  /// Get the [floorIndex], if none is present returns [noFloorIndex]
  int get floorIndex => _floorIndex ?? noFloorIndex;

  /// Get the non-zero area of the point
  @override
  Future<double?> get area async => 0.5;

  /// Used to determine the proper type of a [MPGeometry]
  @override
  String get type => MPGeometry.point;

  /// Converts the [MPPoint] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    if (_lat == null || _lng == null) {
      return {
        "coordinates": [0.0, 0.0],
        "type": type
      };
    }
    List<num> coords = [_lng!, _lat!];

    if (_floorIndex != null) {
      coords.add(_floorIndex!);
    }

    return {"coordinates": coords, "type": type};
  }

  /// Calculates the shortest distance to another [MPPoint]
  Future<num?> distanceTo(MPPoint destination) async =>
      await UtilPlatform.instance.pointDistanceTo(this, destination);

  /// Calculates the angle between this point and another [MPPoint] in degrees from north
  Future<num?> angleBetween(MPPoint other) async =>
      await UtilPlatform.instance.pointAngleBetween(this, other);

  /// Prints this point on the following form:
  ///
  /// "15.00000001,20.20000014,10"
  String getCoordinatesAsString() {
    return "${latitude.toStringAsPrecision(8)},${longitude.toStringAsPrecision(8)}" +
        ((_floorIndex != null) ? ",$floorIndex" : "");
  }

  @override
  String toString() => "Lat: $latitude, Lng: $longitude";

  /// Gets the position of the point, which is [this]
  @override
  MPPoint get position => this;
}
