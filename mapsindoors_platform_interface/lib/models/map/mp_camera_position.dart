part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A camera position object, used to move the camera to a specific position.
class MPCameraPosition extends MapsIndoorsObject {
  late final num zoom;
  late final MPPoint target;
  late final num tilt;
  late final num bearing;

  /// Attempts to build a [MPCameraPosition] from a JSON object, this method will decode the object if needed
  static MPCameraPosition? fromJson(json) => json != null && json != "null"
      ? MPCameraPosition._fromJson(json is String ? jsonDecode(json) : json)
      : null;


  /// Build a Camera Position, with optional tilt and bearing parameters.
  MPCameraPosition({required this.zoom, required this.target, this.tilt = 0, this.bearing = 0});

  MPCameraPosition._fromJson(data) {
    zoom = data["zoom"];
    tilt = data["tilt"];
    bearing = data["bearing"];
    target = MPPoint.fromJson(data["target"])!;
  }

  @override
  Map<String, dynamic> toJson() {
    return {"zoom":zoom, "tilt":tilt, "bearing":bearing, "target":target.toJson()};
  }

}

/// Construct a camera position.
class MPCameraPositionBuilder {

  /// Copy another position to use as a reference.
  MPCameraPositionBuilder.fromPosition(MPCameraPosition position) {
    _zoom = position.zoom;
    _target = position.target;
    _tilt = position.tilt;
    _bearing = position.bearing;
  }

  /// Start the builder, a target and zoom is required to build a [MPCameraPosition]
  MPCameraPositionBuilder({required MPPoint target, required num zoom}) {
    _zoom = zoom;
    _target = target;
  }

  late num _zoom;
  late MPPoint _target;
  num _tilt = 0;
  num _bearing = 0;

  MPCameraPositionBuilder setZoom(num zoom) {
    _zoom = zoom;
    return this;
  }

  MPCameraPositionBuilder setTarget(MPPoint target) {
    _target = target;
    return this;
  }

  MPCameraPositionBuilder setTilt(num tilt) {
    _tilt = tilt;
    return this;
  }

  MPCameraPositionBuilder setBearing(num bearing) {
    _bearing = bearing;
    return this;
  }
  
  MPCameraPosition build() {
    return MPCameraPosition(zoom: _zoom, target: _target, tilt: _tilt, bearing: _bearing);
  }

}