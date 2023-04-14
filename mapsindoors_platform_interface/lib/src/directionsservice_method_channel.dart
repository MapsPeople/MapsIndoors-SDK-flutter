part of 'package:mapsindoors_platform_interface/platform_library.dart';

class MethodChannelDirectionsService extends DirectionsServicePlatform {
  final directionsServiceMethodChannel =
      const MethodChannel('DirectionsServiceMethodChannel');

  @override
  Future<void> create() {
    return directionsServiceMethodChannel.invokeMethod('DSE_create');
  }

  @override
  Future<void> addAvoidWayType(String wayType) {
    return directionsServiceMethodChannel.invokeMethod('DSE_addAvoidWayType', {"wayType":wayType});
  }

  @override
  Future<void> clearWayType() {
    return directionsServiceMethodChannel.invokeMethod('DSE_clearWayType');
  }

  @override
  Future<void> setIsDeparture(bool isDeparture) {
    return directionsServiceMethodChannel.invokeMethod('DSE_setIsDeparture', {"isDeparture":isDeparture});
  }

  @override
  Future<MPRoute> getRoute(MPPoint origin, MPPoint destination) async {
    Map<String, dynamic>? result = await directionsServiceMethodChannel
        .invokeMapMethod('DSE_getRoute', {
      'origin': origin._jsonEncode(),
      'destination': destination._jsonEncode()
    });

    final route = MPRoute.fromJson(result?["route"]);
    final error = MPError.fromJson(result?["error"]);

    if (route != null) {
      return Future.value(route);
    } else if (error != null) {
      return Future.error(error);
    } else {
      return Future.error(MPError(
          code: MPError.unknownError,
          message: "Did not receieve route object from Platform"));
    }
  }

  @override
  Future<void> setTravelMode(String travelMode) {
    return directionsServiceMethodChannel.invokeMethod('DSE_setTravelMode', {"travelMode":travelMode});
  }

  @override
  Future<void> setTime(int time) {
    return directionsServiceMethodChannel.invokeMethod('DSE_setTime', {"time":time});
  }
}
