part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// GeoCode class to represent results from a reverse GeoCode.
class MPGeocodeResult {
  /// Get the [areas], that the [MPPoint] is inside
  late final List<MPLocation> areas;
  /// Get the [rooms], that the [MPPoint] is inside
  late final List<MPLocation> rooms;
  /// Get the [floors], that the [MPPoint] is inside
  late final List<MPLocation> floors;
  /// Get the [buildings], that the [MPPoint] is inside
  late final List<MPLocation> buildings;
  /// Get the [venues], that the [MPPoint] is inside
  late final List<MPLocation> venues;

  /// Attempts to build a [MPFloor] from a JSON object, this method will decode the object if needed
  static MPGeocodeResult? fromJson(json) => json != null && json != "null"
      ? MPGeocodeResult._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPGeocodeResult._fromJson(data) {
    areas = convertMIList<MPLocation>(
        data["areas"], (p0) => MPLocation.fromJson(p0));
    rooms = convertMIList<MPLocation>(
        data["rooms"], (p0) => MPLocation.fromJson(p0));
    floors = convertMIList<MPLocation>(
        data["floors"], (p0) => MPLocation.fromJson(p0));
    buildings = convertMIList<MPLocation>(
        data["buildings"], (p0) => MPLocation.fromJson(p0));
    venues = convertMIList<MPLocation>(
        data["venues"], (p0) => MPLocation.fromJson(p0));
  }
}
