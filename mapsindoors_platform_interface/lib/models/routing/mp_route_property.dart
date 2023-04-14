part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A property of of a [MPRoute]
class MPRouteProperty extends MapsIndoorsObject {
  /// The value of the property
  num? value;
  /// Accompanying text to the value
  String? text;
  String? timeZone;

  /// Converts the [MPRouteProperty] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {"value": value, "text":text, "time_zone":timeZone};
  }

  /// Attempts to build a [MPRouteProperty] from a JSON object, this method will decode the object if needed
  static MPRouteProperty? fromJson(json) => json != null && json != "null"
      ? MPRouteProperty._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPRouteProperty._fromJson(data) {
    value = data["value"];
    text = data["text"];
    timeZone = data["time_zone"];
  }
}
