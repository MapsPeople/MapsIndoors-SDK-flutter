part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An implementation of [MapsindoorsPlatform] that uses method channels.
class MethodChannelDisplayRule extends DisplayRulePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final displayRuleMethodChannel =
      const MethodChannel('DisplayRuleMethodChannel');

  @override
  Future<bool?> isVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isVisible", {"id": id.value});
  }

  @override
  Future<void> setVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<MPIconSize?> getIconSize(MPDisplayRuleId id) async {
    final ret = await displayRuleMethodChannel
        .invokeMethod("DRU_getIconSize", {"id": id.value});
    return MPIconSize.fromJson(ret);
  }

  @override
  Future<String?> getIconUrl(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getIconUrl", {"id": id.value});
  }

  @override
  Future<String?> getLabel(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabel", {"id": id.value});
  }

  @override
  Future<int?> getLabelMaxWidth(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelMaxWidth", {"id": id.value});
  }

  @override
  Future<num?> getLabelZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getLabelZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelZoomTo", {"id": id.value});
  }

  @override
  Future<num?> getModel2DBearing(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DBearing", {"id": id.value});
  }

  @override
  Future<num?> getModel2DHeightMeters(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DHeightMeters", {"id": id.value});
  }

  @override
  Future<String?> getModel2DModel(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DModel", {"id": id.value});
  }

  @override
  Future<num?> getModel2DZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DZoomTo", {"id": id.value});
  }

  @override
  Future<num?> getModel2DWidthMeters(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DWidthMeters", {"id": id.value});
  }

  @override
  Future<num?> getModel2DZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DZoomFrom", {"id": id.value});
  }

  @override
  Future<String?> getPolygonFillColor(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonFillColor", {"id": id.value});
  }

  @override
  Future<num?> getPolygonFillOpacity(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonFillOpacity", {"id": id.value});
  }

  @override
  Future<num?> getPolygonZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonZoomTo", {"id": id.value});
  }

  @override
  Future<String?> getPolygonStrokeColor(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonStrokeColor", {"id": id.value});
  }

  @override
  Future<num?> getPolygonStrokeOpacity(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonStrokeOpacity", {"id": id.value});
  }

  @override
  Future<num?> getPolygonStrokeWidth(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonStrokeWidth", {"id": id.value});
  }

  @override
  Future<num?> getPolygonZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getZoomTo", {"id": id.value});
  }

  @override
  Future<bool?> isIconVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isIconVisible", {"id": id.value});
  }

  @override
  Future<bool?> isLabelVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isLabelVisible", {"id": id.value});
  }

  @override
  Future<bool?> isModel2DVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isModel2DVisible", {"id": id.value});
  }

  @override
  Future<bool?> isPolygonVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isPolygonVisible", {"id": id.value});
  }

  @override
  Future<void> setIcon(MPDisplayRuleId id, String url) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setIcon", {"id": id.value, "url": url});
  }

  @override
  Future<void> setIconSize(MPDisplayRuleId id, MPIconSize size) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setIconSize", {"id": id.value, "size": size._jsonEncode()});
  }

  @override
  Future<void> setIconVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setIconVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setLabel(MPDisplayRuleId id, String label) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setLabel", {"id": id.value, "label": label});
  }

  @override
  Future<void> setLabelMaxWidth(MPDisplayRuleId id, int max) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setLabelMaxWidth", {"id": id.value, "maxWidth": max});
  }

  @override
  Future<void> setLabelVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setLabelVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setLabelZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setLabelZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setLabelZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setLabelZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> setModel2DBearing(MPDisplayRuleId id, num bearing) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DBearing", {"id": id.value, "bearing": bearing});
  }

  @override
  Future<void> setModel2DModel(MPDisplayRuleId id, String model) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DModel", {"id": id.value, "model": model});
  }

  @override
  Future<void> setModel2DHeightMeters(MPDisplayRuleId id, num height) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DHeightMeters", {"id": id.value, "height": height});
  }

  @override
  Future<void> setModel2DVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setModel2DWidthMeters(MPDisplayRuleId id, num width) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DWidthMeters", {"id": id.value, "width": width});
  }

  @override
  Future<void> setModel2DZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setModel2DZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setModel2DZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setModel2DZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> setPolygonFillColor(MPDisplayRuleId id, String color) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setPolygonFillColor", {"id": id.value, "color": color});
  }

  @override
  Future<void> setPolygonFillOpacity(MPDisplayRuleId id, num opacity) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonFillOpacity", {"id": id.value, "opacity": opacity});
  }

  @override
  Future<void> setPolygonStrokeColor(MPDisplayRuleId id, String color) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonStrokeColor", {"id": id.value, "color": color});
  }

  @override
  Future<void> setPolygonStrokeOpacity(
      MPDisplayRuleId id, num opacity) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonStrokeOpacity", {"id": id.value, "opacity": opacity});
  }

  @override
  Future<void> setPolygonStrokeWidth(MPDisplayRuleId id, num width) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonStrokeWidth", {"id": id.value, "width": width});
  }

  @override
  Future<void> setPolygonVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setPolygonZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setPolygonZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setPolygonZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setPolygonZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> setZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<String?> getExtrusionColor(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getExtrusionColor", {"id": id.value});
  }

  @override
  Future<num?> getExtrusionHeight(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getExtrusionHeight", {"id": id.value});
  }

  @override
  Future<num?> getExtrusionZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getExtrusionZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getExtrusionZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getExtrusionZoomTo", {"id": id.value});
  }

  @override
  Future<String?> getWallColor(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getWallColor", {"id": id.value});
  }

  @override
  Future<num?> getWallHeight(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getWallHeight", {"id": id.value});
  }

  @override
  Future<num?> getWallZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getWallZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getWallZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getWallZoomTo", {"id": id.value});
  }

  @override
  Future<bool?> isExtrusionVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isExtrusionVisible", {"id": id.value});
  }

  @override
  Future<bool?> isWallVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isWallVisible", {"id": id.value});
  }

  @override
  Future<void> setExtrusionColor(MPDisplayRuleId id, String color) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setExtrusionColor", {"id": id.value, "color": color});
  }

  @override
  Future<void> setExtrusionHeight(MPDisplayRuleId id, num height) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setExtrusionHeight", {"id": id.value, "height": height});
  }

  @override
  Future<void> setExtrusionVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setExtrusionVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setExtrusionZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setExtrusionZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setExtrusionZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setExtrusionZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> setWallColor(MPDisplayRuleId id, String color) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setWallColor", {"id": id.value, "color": color});
  }

  @override
  Future<void> setWallHeight(MPDisplayRuleId id, num height) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setWallHeight", {"id": id.value, "height": height});
  }

  @override
  Future<void> setWallVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setWallVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setWallZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setWallZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setWallZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setWallZoomTo", {"id": id.value, "zoomTo": to});
  }
  
  @override
  Future<void> reset(MPDisplayRuleId id) {
    return displayRuleMethodChannel.invokeMethod("DRU_reset", {"id": id.value});
  }
}
