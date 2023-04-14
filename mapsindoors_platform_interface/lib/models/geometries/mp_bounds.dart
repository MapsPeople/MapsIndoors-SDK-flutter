part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Describes the geographical bounds as a rectangle spanning from its northeastern point to its southwestern point
class MPBounds extends MapsIndoorsObject {
  late final MPPoint _ne;
  late final MPPoint _sw;
  static MPBoundsBuilder builder() => MPBoundsBuilder();

  /// Build a [MPBounds] from a pair of coordinates
  MPBounds({required MPPoint northeast, required MPPoint southwest}) {
    _ne = northeast;
    _sw = southwest;
  }

  /// Attempts to build a [MPBounds] from a JSON object, this method will decode the object if needed
  static MPBounds? fromJson(json) => json != null && json != "null"
      ? MPBounds._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPBounds._fromJson(data) {
    _ne = MPPoint.fromJson(data["northeast"])!;
    _sw = MPPoint.fromJson(data["southwest"])!;
  }

  /// Get the southwestern point
  MPPoint get southwest => _sw;

  /// Get the northeastern point
  MPPoint get northeast => _ne;

  /// Calculates the center of the bounds
  MPPoint get center {
    var latCenter = (northeast.latitude + southwest.latitude) / 2.0;
    var lngCenter = (northeast.longitude + _sw.longitude) / 2.0;
    return MPPoint.withCoordinates(latitude: latCenter, longitude: lngCenter);
  }

  /// Check whether a [point] is inside the bounds
  bool contains(MPPoint point) => ((point.latitude <= northeast.latitude &&
          point.latitude >= southwest.latitude) &&
      (point.longitude <= northeast.longitude &&
          point.longitude >= southwest.longitude));

  /// Converts the [MPBounds] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() =>
      {"northeast": _ne.toJson(), "southwest": _sw.toJson()};

  @override
  String toString() => "NE: $_ne, SW: $_sw";
}

/// Build a [MPBounds] from a collection of [MPPoint]s, 
/// note that at least one point has to be supplied before the bounds can be built
class MPBoundsBuilder {
  num _north = -double.maxFinite;
  num _south = double.maxFinite;
  num _east = -double.maxFinite;
  num _west = double.maxFinite;

  MPBoundsBuilder();

  /// Include a [point] in the [MPBounds], if the [point] is outside the bounds, the bounds will be expanded to include the point
  MPBoundsBuilder include(MPPoint point) {
    _north = max(_north, point.latitude);
    _south = min(_south, point.latitude);
    _east = max(_east, point.longitude);
    _west = min(_west, point.longitude);
    return this;
  }

  /// Build a [MPBounds] object
  /// 
  /// Throws FormatException if no [MPPoint]s were added in with [include]
  MPBounds build() {
    if (_north == -double.maxFinite) {
      throw const FormatException("Cannot build bounds with no coordinates");
    }
    return MPBounds(northeast: MPPoint.withCoordinates(latitude: _north, longitude: _east),
                    southwest: MPPoint.withCoordinates(latitude: _south, longitude: _west));
  }
}
