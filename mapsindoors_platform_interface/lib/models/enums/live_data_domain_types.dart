part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Domain types for livedata subscriptions
/// 
/// Used to set which livedata domains are active on MapControl.enableLiveData(String)
enum LiveDataDomainTypes {
  occupancy("occupancy"),
  availability("availability"),
  position("position"),
  count("count"),
  temperature("temperature"),
  co2("co2"),
  humidity("humidity"),
  any("any");

  final String name;
  const LiveDataDomainTypes(this.name);

  dynamic toJson() => name;
}
