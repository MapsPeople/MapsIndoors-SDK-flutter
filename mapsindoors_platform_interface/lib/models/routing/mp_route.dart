part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A route from a origin to a destination broken up into [MPRouteLeg] [legs]
class MPRoute extends MapsIndoorsObject {
  /// The [legs] the route consists of
  List<MPRouteLeg>? legs;
  /// The [copyrights] for this route, if any
  String? copyrights;
  /// A [summary] of the route
  String? summary;
  /// Any [warnings] issued for any paths on the route
  List<String>? warnings;
  /// All [restrictions] in place for the route
  List<String>? restrictions;
  /// The outer [bounds] of the route
  MPBounds? bounds;

  /// Converts the [MPRoute] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    var jsonLegs = legs?.map((e) => e.toJson()).toList();
    return {
      "legs": jsonLegs,
      "copyrights": copyrights,
      "summary": summary,
      "warnings": warnings,
      "restrictions": restrictions,
      "bounds": bounds?.toJson()
    };
  }

  /// Attempts to build a [MPRoute] from a JSON object, this method will decode the object if needed
  static MPRoute? fromJson(json) => json != null && json != "null"
      ? MPRoute._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPRoute._fromJson(data) {
    copyrights = data["copyrights"];
    summary = data["summary"];
    warnings = convertJsonArray(data["warnings"]);
    restrictions = convertJsonArray(data["restrictions"]);
    var list = convertJsonArray(data["legs"]);
    var routeLegs = List<MPRouteLeg?>.generate(
        list.length, (index) => MPRouteLeg.fromJson(list[index]));
    routeLegs.removeWhere((element) => element == null);
    legs = routeLegs.cast<MPRouteLeg>();
  }
}
