part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// OSM highways used by the MapsIndoors SDK in addition to MapsIndoors specific highways
enum MPHighway {
  unclassified("unclassified"),
  footway("footway"),
  residential("residential"),
  service("service"),
  ramp("ramp"),
  steps("steps"),
  escalator("escalator"),
  travelator("travelator"),
  elevator("elevator"),
  wheelChairRamp("wheelchairramp"),
  wheelChairLift("wheelchairlift"),
  ladder("ladder");

  final String name;
  const MPHighway(this.name);

  dynamic toJson() => name;
}
