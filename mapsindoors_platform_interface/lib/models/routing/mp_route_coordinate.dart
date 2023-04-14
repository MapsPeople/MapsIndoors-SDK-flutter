part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A coordinate used for routing, it is contained within a [MPRouteStep]
/// 
/// Is the smallest building block of a [MPRoute]
class MPRouteCoordinate extends MapsIndoorsObject {
  /// The latitude of the coordinate
  num? latitude;
  /// The longitude of the coordinate
  num? longitude;
  /// The index of the floor the coordinate is on
  num? floorIndex;
  /// The name of the floor the coordinate is on
  String? floorname;

  /// Converts the [MPRouteCoordinate] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {
      "lat": latitude,
      "lng": longitude,
      "zLevel": floorIndex,
      "floor_name": floorname
    };
  }

  /// Attempts to build a [MPRouteCoordinate] from a JSON object, this method will decode the object if needed
  static MPRouteCoordinate? fromJson(json) => json != null && json != "null"
      ? MPRouteCoordinate._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPRouteCoordinate._fromJson(data) {
    latitude = data["lat"];
    longitude = data["lng"];
    floorIndex = data["zLevel"];
    floorname = data["floor_name"];
  }
}
