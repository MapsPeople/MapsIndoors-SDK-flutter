part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// This configuration object is used when creating a new [MapControl] instance.
class MPMapConfig extends MapsIndoorsObject {
  String? _typeface;
  String? _color;
  bool? _showHalo;
  int? _textSize;
  bool? _showFloorSelector;
  bool? _showInfoWindowOnClick;
  bool? _showUserPosition;
  bool? _enabletileFadeIn;
  bool _useDefaultMapsIndoorsStyle = true;
  MPFloorSelectorInterface? _floorSelector;

  //setInfoWindowAdapter
  //setClusterIconAdapter

  /// Changes the font of the maps marker labels
  /// 
  /// Change the [typeface] (the typeface must be supported on the native platform).
  /// Change the [color] with a Hex color String (#1f1f1f)
  /// Change whether the text will have a white shadow
  MPMapConfig setMapLabelFont(String typeface, String color, bool showHalo) {
    _typeface = typeface;
    _color = color;
    _showHalo = showHalo;
    return this;
  }

  /// Sets whether to use the default map styling used by MapsIndoors, enabled by default
  MPMapConfig setUseDefaultMapsIndoorsStyle(bool use) {
    _useDefaultMapsIndoorsStyle = use;
    return this;
  }

  /// Changes the text size of the maps marker labels
  /// 
  /// The size is in dense pixels (DP)
  MPMapConfig setMapLabelTextSize(int textSize) {
    _textSize = textSize;
    return this;
  }

  /// Enable/Disable showing the floor selector
  MPMapConfig setShowFloorSelector(bool show) {
    _showFloorSelector = show;
    return this;
  }

  /// Enables/Disables the info window on user-selected locations
  /// 
  /// The info window is shown by default when the user selects a location (by tapping on it)
  MPMapConfig setShowInfoWindowOnLocationClicked(bool show) {
    _showInfoWindowOnClick = show;
    return this;
  }

  /// Renders the positioning puck (blue dot) at the last known user position on the map
  MPMapConfig setShowUserPosition(bool show) {
    _showUserPosition = show;
    return this;
  }

  /// Enable fade-in effect on MapsIndoors tiles.
  /// Changes will be reflected on the map upon changing floors.
  /// 
  /// Default behavior is enabled fade-in.
  MPMapConfig setTileFadeInEnabled(bool enable) {
    _enabletileFadeIn = enable;
    return this;
  }

  /// Replaces the default FloorSelector with a custom one.
  MPMapConfig setFloorSelector(MPFloorSelectorInterface floorSelector) {
    _floorSelector = floorSelector;
    return this;
  }

  /// Converts the [MPMapConfig] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    final map = {
      "typeface": _typeface,
      "color": _color,
      "showHalo": _showHalo,
      "textSize": _textSize,
      "showFloorSelector": _showFloorSelector,
      "showInfoWindowOnLocationClicked": _showInfoWindowOnClick,
      "showUserPosition": _showUserPosition,
      "useDefaultMapsIndoorsStyle": _useDefaultMapsIndoorsStyle,
      "tileFadeInEnabled": _enabletileFadeIn
    };
    map.removeWhere((_, value) => value == null);
    return map;
  }
}
