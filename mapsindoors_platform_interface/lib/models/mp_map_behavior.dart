part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Sets a behavior for the map when calling [MapControl.setFilter()]
/// 
/// Has a [DEFAULT] behavior
@immutable
class MPFilterBehavior extends MapsIndoorsObject {
  /// The default behavior for filtering:
  /// 
  /// MoveCamera = false
  /// 
  /// ShowInfoWindow = false
  /// 
  /// AnimationDuration = 0
  /// 
  /// AllowFloorChange = false
  /// 
  /// ZoomToFit = true
  static final MPFilterBehavior DEFAULT =
      MPFilterBehavior._(false, false, 0, false, true);

  /// Get a builder object
  static MPFilterBehaviorBuilder builder() => MPFilterBehaviorBuilder();

  /// Whether the filtering is allowed to change the floor if no results are visible on the current floor
  final bool allowFloorChange;
  /// Whether the filtering should move the camera to encompass the results
  final bool moveCamera;
  /// How long the camera movement should be animated for, set to 0 disables animation
  final int animationDuration;
  /// Whether to open the info window if a single result is returned
  final bool showInfoWindow;
  /// Whether the filtering is allowed to zoom in/out the camera
  final bool zoomToFit;

  MPFilterBehavior._(this.allowFloorChange, this.moveCamera,
      this.animationDuration, this.showInfoWindow, this.zoomToFit);

  /// Converts the [MPFilterBehavior] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {
      "allowFloorChange": allowFloorChange,
      "moveCamera": moveCamera,
      "animationDuration": animationDuration,
      "showInfoWindow": showInfoWindow,
      "zoomToFit": zoomToFit
    };
  }
}

/// Sets a behavior for the map when calling [MapControl.selectLocation()]
/// 
/// Has a [DEFAULT] behavior
class MPSelectionBehavior extends MapsIndoorsObject {

  /// The default behavior for selection:
  /// 
  /// Animate camera = true
  /// 
  /// Show InfoWindow = true
  /// 
  /// Animation duration = 500
  /// 
  /// Allow floor change = true
  /// 
  /// Zoom to fit = true
  static final MPSelectionBehavior DEFAULT =
      MPSelectionBehavior._(true, true, 500, true, true);

  /// Get a builder object
  static MPSelectionBehaviorBuilder builder() => MPSelectionBehaviorBuilder();

  /// Whether the filtering is allowed to change the floor if no results are visible on the current floor
  final bool allowFloorChange;
  /// Whether the filtering should move the camera to encompass the results
  final bool moveCamera;
  /// How long the camera movement should be animated for, set to 0 disables animation
  final int animationDuration;
  /// Whether to open the info window if a single result is returned
  final bool showInfoWindow;
  /// Whether the filtering is allowed to zoom in/out the camera
  final bool zoomToFit;

  MPSelectionBehavior._(this.allowFloorChange, this.moveCamera,
      this.animationDuration, this.showInfoWindow, this.zoomToFit);

  /// Converts the [MPSelectionBehavior] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {
      "allowFloorChange": allowFloorChange,
      "moveCamera": moveCamera,
      "animationDuration": animationDuration,
      "showInfoWindow": showInfoWindow,
      "zoomToFit": zoomToFit
    };
  }
}

/// Map behavior builder
abstract class Builder<T> {
  bool? _allowFloorChange;
  bool? _moveCamera;
  int? _animationDuration;
  bool? _showInfoWindow;
  bool? _zoomToFit;

  /// Set whether the filtering is [allow]ed to change the floor if no results are visible on the current floor
  Builder<T> setAllowFloorChange(bool allow) {
    _allowFloorChange = allow;
    return this;
  }

  /// Set whether the filtering should [move] the camera to encompass the results
  Builder<T> setMoveCamera(bool move) {
    _moveCamera = move;
    return this;
  }

  /// Set the [duration] the camera movement should be animated for, set to 0 to disable animation
  Builder<T> setAnimationDuration(int duration) {
    _animationDuration = duration;
    return this;
  }

  /// Set whether to open the info window if a single result is returned
  Builder<T> setShowInfoWindow(bool show) {
    _showInfoWindow = show;
    return this;
  }

  /// Set whether the filtering is allowed to zoom the camera in/out
  Builder<T> setZoomToFit(bool doFit) {
    _zoomToFit = doFit;
    return this;
  }

  /// Build the behavior object
  T build();
}

/// Builder for [MPFilterBehavior]
class MPFilterBehaviorBuilder extends Builder<MPFilterBehavior> {
  @override
  MPFilterBehavior build() {
    return MPFilterBehavior._(
        _allowFloorChange ?? MPFilterBehavior.DEFAULT.allowFloorChange,
        _moveCamera ?? MPFilterBehavior.DEFAULT.moveCamera,
        _animationDuration ?? MPFilterBehavior.DEFAULT.animationDuration,
        _showInfoWindow ?? MPFilterBehavior.DEFAULT.showInfoWindow,
        _zoomToFit ?? MPFilterBehavior.DEFAULT.zoomToFit);
  }
}

/// Builder for [MPSelectionBehavior]
class MPSelectionBehaviorBuilder extends Builder<MPSelectionBehavior> {
  @override
  MPSelectionBehavior build() {
    return MPSelectionBehavior._(
        _allowFloorChange ?? MPSelectionBehavior.DEFAULT.allowFloorChange,
        _moveCamera ?? MPSelectionBehavior.DEFAULT.moveCamera,
        _animationDuration ?? MPSelectionBehavior.DEFAULT.animationDuration,
        _showInfoWindow ?? MPSelectionBehavior.DEFAULT.showInfoWindow,
        _zoomToFit ?? MPSelectionBehavior.DEFAULT.zoomToFit);
  }
}
