part of 'package:mapsindoors/mapsindoors.dart';

class MPDirectionsService {

  static final String travelModeTransit = "transit";
  static final String travelModeDriving = "driving";
  static final String travelModeWalking = "walking";
  static final String travelModeBicycling = "bicycling";


  /// Creates a [MPDirectionsService] object than can be queried for directions between different [MPPoint]s
  MPDirectionsService() {
    _create();
  }

  void _create() {
    DirectionsServicePlatform.instance.create();
  }

  /// Add an avoidWayType, these are based on [OSM highways](https://wiki.openstreetmap.org/wiki/Key:highway)
  /// 
  /// Supported types are defined in [MPHighway]
  Future<void> addAvoidWayType(String avoidWayType) =>
    DirectionsServicePlatform.instance.addAvoidWayType(avoidWayType);

  /// Clears all added avoidWayTypes
  Future<void> clearWayType() =>
    DirectionsServicePlatform.instance.clearWayType();

  /// Sets whether routes should use departure time or arrival time when using the transit travel mode
  Future<void> setIsDeparture(bool isDeparture) =>
    DirectionsServicePlatform.instance.setIsDeparture(isDeparture);

  /// Queries the routing network to generate a route from the [origin] to the [destination].
  /// 
  /// Can throw an [MPError] if unable to generate the route.
  Future<MPRoute> getRoute({required MPPoint origin,  required MPPoint destination}) =>
    DirectionsServicePlatform.instance.getRoute(origin, destination);

  /// defines the travel mode for routes, can be one of the following:
  /// 
  /// walking
  /// 
  /// bicycling
  /// 
  /// driving
  /// 
  /// transit
  Future<void> setTravelMode(String travelMode) =>
    DirectionsServicePlatform.instance.setTravelMode(travelMode);

  /// sets the wanted arrival/departure time for routes generated with this [MPDirectionsService],
  /// this setting is used in conjunction with [setIsDeparture] and [setTravelMode]
  Future<void> setTime(int time) =>
    DirectionsServicePlatform.instance.setTime(time);
}
