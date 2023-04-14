part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A unique identifier for display rules
@immutable
class MPDisplayRuleId extends DynamicObjectId {
  const MPDisplayRuleId(String value) : super(value);
}

/// A collection of settings that dictate how MapsIndoors objects are displayed on the map
@immutable
class MPDisplayRule implements DynamicObject<MPDisplayRuleId> {
  const MPDisplayRule._(this._id);

  final MPDisplayRuleId _id;

  /// Get the display rule's [id]
  @override
  MPDisplayRuleId get id => _id;

  /// The name of the display rule
  String get dispalyRuleName => _id.value;

  /// Get the general visibility value
  Future<bool?> isVisible() =>
      DisplayRulePlatform.instance.isVisible(id);

  /// Set the general visibility value
  Future<void> setVisible(bool visible) =>
      DisplayRulePlatform.instance.setVisible(id, visible);

  /// Get the icon's visibility value
  Future<bool?> isIconVisible() =>
      DisplayRulePlatform.instance.isIconVisible(id);

  /// Set the icon's visibility value 
  Future<void> setIconVisible(bool visible) =>
      DisplayRulePlatform.instance.setIconVisible(id, visible);

  /// Get the general zoom from value
  Future<num?> getZoomFrom() =>
      DisplayRulePlatform.instance.getZoomFrom(id);

  /// Set the general zoom from value
  Future<void> setZoomFrom(num from) =>
      DisplayRulePlatform.instance.setZoomFrom(id, from);

  /// Get the general zoom to value
  Future<num?> getZoomTo() =>
      DisplayRulePlatform.instance.getZoomTo(id);

  /// Set the general zoom to value
  Future<void> setZoomTo(num to) =>
      DisplayRulePlatform.instance.setZoomTo(id, to);

  /// Get the icon's URL
  Future<String?> getIconUrl() =>
      DisplayRulePlatform.instance.getIconUrl(id);

  /// Set the icon's URL
  Future<void> setIcon(String url) =>
      DisplayRulePlatform.instance.setIcon(id, url);

  /// Get the icon's size
  Future<MPIconSize?> getIconSize() =>
      DisplayRulePlatform.instance.getIconSize(id);

  /// Set the icon's size
  Future<void> setIconSize(MPIconSize size) =>
      DisplayRulePlatform.instance.setIconSize(id, size);

  /// Get the label's visibility value
  Future<bool?> isLabelVisible() =>
      DisplayRulePlatform.instance.isLabelVisible(id);

  /// Set the label's visibility value
  Future<void> setLabelVisible(bool visible) =>
      DisplayRulePlatform.instance.setLabelVisible(id, visible);

  /// Get the label string
  Future<String?> getLabel() =>
      DisplayRulePlatform.instance.getLabel(id);

  /// Set the label string
  Future<void> setLabel(String label) =>
      DisplayRulePlatform.instance.setLabel(id, label);

  /// Get the label's zoom from value
  Future<num?> getLabelZoomFrom() =>
      DisplayRulePlatform.instance.getLabelZoomFrom(id);

  /// Set the label's zoom from value
  Future<void> setLabelZoomFrom(num from) =>
      DisplayRulePlatform.instance.setLabelZoomFrom(id, from);

  /// Get the label's zoom to value
  Future<num?> getLabelZoomTo() =>
      DisplayRulePlatform.instance.getLabelZoomTo(id);

  /// Set the label's zoom to value
  Future<void> setLabelZoomTo(num to) =>
      DisplayRulePlatform.instance.setLabelZoomTo(id, to);

  /// Get the label's max width value
  Future<int?> getLabelMaxWidth() =>
      DisplayRulePlatform.instance.getLabelMaxWidth(id);

  /// Set the label's max width value
  Future<void> setLabelMaxWidth(int max) =>
      DisplayRulePlatform.instance.setLabelMaxWidth(id, max);

  // polygon
  /// Get the polygon's visibility value
  Future<bool?> isPolygonVisible() =>
      DisplayRulePlatform.instance.isPolygonVisible(id);

  /// Set the polygon's visibility value
  Future<void> setPolygonVisible(bool visible) =>
      DisplayRulePlatform.instance.setPolygonVisible(id, visible);

  /// Get the polygon's zoom from value
  Future<num?> getPolygonZoomFrom() =>
      DisplayRulePlatform.instance.getPolygonZoomFrom(id);

  /// Set the polygon's zoom from value
  Future<void> setPolygonZoomFrom(num from) =>
      DisplayRulePlatform.instance.setPolygonZoomFrom(id, from);

  /// Get the polygon's zoom to value
  Future<num?> getPolygonZoomTo() =>
      DisplayRulePlatform.instance.getPolygonZoomTo(id);

  /// Set the polygon's zoom to value
  Future<void> setPolygonZoomTo(num to) =>
      DisplayRulePlatform.instance.setPolygonZoomTo(id, to);

  /// Get the polygon's stroke width value
  Future<num?> getPolygonStrokeWidth() =>
      DisplayRulePlatform.instance.getPolygonStrokeWidth(id);

  /// Set the polygon's stroke width value
  Future<void> setPolygonStrokeWidth(num width) =>
      DisplayRulePlatform.instance.setPolygonStrokeWidth(id, width);

  /// Get the polygon's stroke color value
  Future<String?> getPolygonStrokeColor() =>
      DisplayRulePlatform.instance.getPolygonStrokeColor(id);

  /// Set the polygon's stroke color value
  Future<void> setPolygonStrokeColor(String color) =>
      DisplayRulePlatform.instance.setPolygonStrokeColor(id, color);

  /// Get the polygon's stroke opacity value
  Future<num?> getPolygonStrokeOpacity() =>
      DisplayRulePlatform.instance.getPolygonStrokeOpacity(id);

  /// Set the polygon's stroke opacity value
  Future<void> setPolygonStrokeOpacity(num opacity) =>
      DisplayRulePlatform.instance.setPolygonStrokeOpacity(id, opacity);

  /// Get the polygon's fill color value
  Future<String?> getPolygonFillColor() =>
      DisplayRulePlatform.instance.getPolygonFillColor(id);

  /// Set the polygon's fill color value
  Future<void> setPolygonFillColor(String color) =>
      DisplayRulePlatform.instance.setPolygonFillColor(id, color);

  /// Get the polygon's fill opacity value
  Future<num?> getPolygonFillOpacity() =>
      DisplayRulePlatform.instance.getPolygonFillOpacity(id);

  /// Set the polygon's fill opacity value
  Future<void> setPolygonFillOpacity(num opacity) =>
      DisplayRulePlatform.instance.setPolygonFillOpacity(id, opacity);

  // wall
  /// Get the wall's visibility value
  Future<bool?> isWallVisible() =>
      DisplayRulePlatform.instance.isWallVisible(id);

  /// Set the wall's visibility value
  Future<void> setWallVisible(bool visible) =>
      DisplayRulePlatform.instance.setWallVisible(id, visible);

  /// Get the wall's color value
  Future<String?> getWallColor() =>
      DisplayRulePlatform.instance.getWallColor(id);

  /// Set the wall's color value
  Future<void> setWallColor(String color) =>
      DisplayRulePlatform.instance.setWallColor(id, color);

  /// Get the wall's height value
  Future<num?> getWallHeight() =>
      DisplayRulePlatform.instance.getWallHeight(id);

  /// Set the wall's height value
  Future<void> setWallHeight(num height) =>
      DisplayRulePlatform.instance.setWallHeight(id, height);

  /// Get the wall's zoom from value
  Future<num?> getWallZoomFrom() =>
      DisplayRulePlatform.instance.getWallZoomFrom(id);

  /// Set the wall's zoom from value
  Future<void> setWallZoomFrom(num from) =>
      DisplayRulePlatform.instance.setWallZoomFrom(id, from);

  /// Get the wall's zoom to value
  Future<num?> getWallZoomTo() =>
      DisplayRulePlatform.instance.getWallZoomTo(id);

  /// Set the wall's zoom to value
  Future<void> setWallZoomTo(num to) =>
      DisplayRulePlatform.instance.setWallZoomTo(id, to);

  //extrusion
  /// Get the extrusion's visibility value
  Future<bool?> isExtrusionVisible() =>
      DisplayRulePlatform.instance.isExtrusionVisible(id);

  /// Set the extrusion's visibility value
  Future<void> setExtrusionVisible(bool visible) =>
      DisplayRulePlatform.instance.setExtrusionVisible(id, visible);

  /// Get the extrusion's color value
  Future<String?> getExtrusionColor() =>
      DisplayRulePlatform.instance.getExtrusionColor(id);

  /// Set the extrusion's color value
  Future<void> setExtrusionColor(String color) =>
      DisplayRulePlatform.instance.setExtrusionColor(id, color);

  /// Get the extrusion's height value
  Future<num?> getExtrusionHeight() =>
      DisplayRulePlatform.instance.getExtrusionHeight(id);

  /// Set the extrusion's height value
  Future<void> setExtrusionHeight(num height) =>
      DisplayRulePlatform.instance.setExtrusionHeight(id, height);

  /// Get the extrusion's zoom from value
  Future<num?> getExtrusionZoomFrom() =>
      DisplayRulePlatform.instance.getExtrusionZoomFrom(id);

  /// Set the extrusion's zoom from value
  Future<void> setExtrusionZoomFrom(num from) =>
      DisplayRulePlatform.instance.setExtrusionZoomFrom(id, from);

  /// Get the extrusion's zoom to value
  Future<num?> getExtrusionZoomTo() =>
      DisplayRulePlatform.instance.getExtrusionZoomTo(id);

  /// Set the extrusion's zoom to value
  Future<void> setExtrusionZoomTo(num to) =>
      DisplayRulePlatform.instance.setExtrusionZoomTo(id, to);

  //2d models
  /// Get the 2D model's visibility value
  Future<bool?> isModel2DVisible() =>
      DisplayRulePlatform.instance.isModel2DVisible(id);

  /// Set the 2D model's visibility value
  Future<void> setModel2DVisible(bool visible) =>
      DisplayRulePlatform.instance.setModel2DVisible(id, visible);

  /// Get the 2D model's zoom from value
  Future<num?> getModel2DZoomFrom() =>
      DisplayRulePlatform.instance.getModel2DZoomFrom(id);

  /// Set the 2D model's zoom from value
  Future<void> setModel2DZoomFrom(num from) =>
      DisplayRulePlatform.instance.setModel2DZoomFrom(id, from);

  /// Get the 2D model's zoom to value
  Future<num?> getModel2DZoomTo() =>
      DisplayRulePlatform.instance.getModel2DZoomTo(id);

  /// Set the 2D model's zoom to value
  Future<void> setModel2DZoomTo(num to) =>
      DisplayRulePlatform.instance.setModel2DZoomTo(id, to);

  /// Get the 2D model's URL
  Future<String?> getModel2DModel() =>
      DisplayRulePlatform.instance.getModel2DModel(id);

  /// Set the 2D model's URL
  Future<void> setModel2DModel(String url) =>
      DisplayRulePlatform.instance.setModel2DModel(id, url);

  /// Get the 2D model's width in meters
  Future<num?> getModel2DWidthMeters() =>
      DisplayRulePlatform.instance.getModel2DWidthMeters(id);

  /// Set the 2D model's width in meters
  Future<void> setModel2DWidthMeters(num width) =>
      DisplayRulePlatform.instance.setModel2DWidthMeters(id, width);

  /// Get the 2D model's height in meters
  Future<num?> getModel2DHeightMeters() =>
      DisplayRulePlatform.instance.getModel2DHeightMeters(id);

  /// Set the 2D model's height in meters
  Future<void> setModel2DHeightMeters(num height) =>
      DisplayRulePlatform.instance.setModel2DHeightMeters(id, height);

  /// Get the 2D model's bearing value
  Future<num?> getModel2DBearing() =>
      DisplayRulePlatform.instance.getModel2DBearing(id);

  /// Get the 2D model's bearing value
  Future<void> setModel2DBearing(num bearing) =>
      DisplayRulePlatform.instance.setModel2DBearing(id, bearing);

  Future<void> reset() => DisplayRulePlatform.instance.reset(id);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MPDisplayRule && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
