part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A step of a [MPRoute], the step is usually contained in a [MPRouteLeg]
class MPRouteStep extends MapsIndoorsObject {
  /// The [distance] of the step
  MPRouteProperty? distance;

  /// The estimated [duration] of the step
  MPRouteProperty? duration;

  /// The origin of the step
  MPRouteCoordinate? startLocation;

  /// The destination of the step
  MPRouteCoordinate? endLocation;

  /// The coordinates the step is made up of
  List<MPRouteCoordinate>? geometry;

  /// The type of [MPHighway] of the step
  String? highway;

  /// Some [abutters] set on the step
  String? abutters;

  /// The step [maneuver] embedded in HTML
  String? htmlInstructions;

  /// The steps' [maneuver], eg. "Straight", "Turn lef"
  String? maneuver;

  /// How the step is traversed
  String? travelMode;

  /// A list of substeps if any
  List<MPRouteStep>? steps;

  /// A list of modes it is possible to travel the step with (eg. a bike path can both be walked on, as well as biked on)
  List<String>? availableTravelModes;

  /// Converts the [MPRouteStep] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    var jsonRouteSteps = steps?.map((e) => e.toJson()).toList();
    var jsonGeometry = geometry?.map((e) => e.toJson()).toList();
    return {
      "distance": distance?.toJson(),
      "duration": duration?.toJson(),
      "start_location": startLocation?.toJson(),
      "end_location": endLocation?.toJson(),
      "geometry": jsonGeometry,
      "highway": highway,
      "abutters": abutters,
      "html_instructions": htmlInstructions,
      "maneuver": maneuver,
      "travel_mode": travelMode,
      "steps": jsonRouteSteps,
      "available_travel_modes": availableTravelModes
    };
  }

  /// Attempts to build a [MPRouteStep] from a JSON object, this method will decode the object if needed
  static MPRouteStep? fromJson(json) => json != null && json != "null"
      ? MPRouteStep._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPRouteStep._fromJson(data) {
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
    if (data["highway"] is String) {
      highway = data["highway"];
    } else {
      highway = data["highway"]["value"];
    }
    abutters = data["abutters"];
    htmlInstructions = data["html_instructions"];
    maneuver = data["maneuver"];
    travelMode = data["travel_mode"];
    if (data["available_travel_modes"] != null) {
      availableTravelModes = convertJsonArray(data["available_travel_modes"]);
    }

    if (data["steps"] != null) {
      var jsonRouteSteps = convertJsonArray(data["steps"]);
      var routeSteps = List<MPRouteStep?>.generate(jsonRouteSteps.length,
          (index) => MPRouteStep.fromJson(jsonRouteSteps[index]));
      routeSteps.removeWhere((element) => element == null);
      steps = routeSteps.cast<MPRouteStep>();
    }

    if (data["geometry"] != null) {
      var jsonGeometry = convertJsonArray(data["geometry"]);
      var routeGeometry = List<MPRouteCoordinate?>.generate(jsonGeometry.length,
          (index) => MPRouteCoordinate.fromJson(jsonGeometry[index]));
      routeGeometry.removeWhere((element) => element == null);
      geometry = routeGeometry.cast<MPRouteCoordinate>();
    }
  }
}
