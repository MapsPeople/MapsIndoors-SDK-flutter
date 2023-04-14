part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A leg of a [MPRoute] is defined as all steps between any context shifts (entering/exiting buildings, changing floors)
/// A leg is comprised of a list of [steps] as well as a [startLocation] and an [endLocation]
class MPRouteLeg extends MapsIndoorsObject {
  /// The start address of the leg
  String? startAdress;

  /// The end address of the leg
  String? endAddress;

  /// The start coordinate of the leg
  MPRouteCoordinate? startLocation;

  /// The end coordinate of the lg
  MPRouteCoordinate? endLocation;

  /// The [steps] the leg consists of
  List<MPRouteStep>? steps;

  /// The distance of the leg
  MPRouteProperty? distance;

  /// The expected time it takes to traverse
  MPRouteProperty? duration;

  /// Converts the [MPRouteLeg] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    var jsonMPRouteSteps = steps?.map((e) => e.toJson()).toList();
    return {
      "start_address": startAdress,
      "end_address": endAddress,
      "start_location": startLocation?.toJson(),
      "end_location": endLocation?.toJson(),
      "steps": jsonMPRouteSteps,
      "distance": distance?.toJson(),
      "duration": duration?.toJson()
    };
  }

  /// Attempts to build a [MPRouteLeg] from a JSON object, this method will decode the object if needed
  static MPRouteLeg? fromJson(json) => json != null && json != "null"
      ? MPRouteLeg._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPRouteLeg._fromJson(data) {
    endAddress = data["end_address"];
    startAdress = data["start_address"];
    if (data["distance"] is num) {
      distance = MPRouteProperty.fromJson({
        "value": data["distance"],
        "text": "blala",
        "time_zone": "i am a timezone"
      });
    } else {
      distance = MPRouteProperty.fromJson(data["distance"]);
    }
    if (data["duration"] is num) {
      duration = MPRouteProperty.fromJson({
        "value": data["duration"],
        "text": "blala",
        "time_zone": "i am a timezone"
      });
    } else {
      duration = MPRouteProperty.fromJson(data["duration"]);
    }
    startLocation = MPRouteCoordinate.fromJson(data["start_location"]);
    endLocation = MPRouteCoordinate.fromJson(data["end_location"]);
    var list = convertJsonArray(data["steps"]);
    var routeSteps = List<MPRouteStep?>.generate(
        list.length, (index) => MPRouteStep.fromJson(list[index]));
    routeSteps.removeWhere((element) => element == null);
    steps = routeSteps.cast<MPRouteStep>();
  }
}
