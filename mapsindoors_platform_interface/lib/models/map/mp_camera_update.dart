part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An object that can be used to update the position of the camera by calling MapControl.animateCamera().
class MPCameraUpdate extends MapsIndoorsObject{
  late final Map<String, dynamic> _map;

  /// Construct the update from a point.
  MPCameraUpdate.fromPoint(MPPoint point) {
    _map = {"mode":"fromPoint", "point":point.toJson()};
  }

  /// Construct the update from a bounding box with some padding.
  MPCameraUpdate.fromBounds({required MPBounds bounds, required int padding, int? width, int? height}) {
    _map = {"mode":"fromBounds", "bounds":bounds.toJson(), "padding":padding, "width":width, "height":height};
    _map.removeWhere((key, value) => value == null);
  }

  /// Zooms the camera by the given amount.
  MPCameraUpdate.zoomBy(num amount) {
    _map = {"mode":"zoomBy", "zoom":amount};
  }

  /// Zooms the camera to the given level.
  MPCameraUpdate.zoomTo(num zoom) {
    _map = {"mode":"zoomTo", "zoom":zoom};
  }

  /// Constructs the update from the given position.
  MPCameraUpdate.fromCameraPosition(MPCameraPosition position) {
    _map = {"mode":"fromCameraPosition", "position":position.toJson()};
  }

  @override
  Map<String, dynamic> toJson() {
    return _map;
  }

}