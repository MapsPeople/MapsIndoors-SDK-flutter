part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Object that is returned from [MPDirectionsSerivce.getRoute()]
class MPRouteResult {
  final MPRoute? route;
  final MPError? error;

  MPRouteResult._(this.route, this.error);
}