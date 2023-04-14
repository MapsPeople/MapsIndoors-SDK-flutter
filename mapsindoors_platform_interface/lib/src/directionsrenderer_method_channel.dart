part of 'package:mapsindoors_platform_interface/platform_library.dart';

class MethodChannelDirectionsRenderer extends DirectionsRendererPlatform {
  final directionsRendererMethodChannel =
      const MethodChannel('DirectionsRendererMethodChannel');

  OnLegSelectedListener? _onLegSelectedListener;

  MethodChannelDirectionsRenderer() {
    directionsRendererMethodChannel.setMethodCallHandler((call) => _listenerHandler(call));
  }

  Future<dynamic> _listenerHandler(MethodCall call) async {
    switch (call.method) {
      case "onLegSelected":
        {
          final int legIndex = call.arguments;
          _onLegSelectedListener?.onLegSelected(legIndex);
        }
    }
  }

  @override
  Future<void> clear() =>
    directionsRendererMethodChannel.invokeMethod('DRE_clear');
  

  @override
  Future<void> nextLeg() =>
    directionsRendererMethodChannel.invokeMethod('DRE_nextLeg');

  @override
  Future<void> previousLeg() =>
    directionsRendererMethodChannel.invokeMethod('DRE_previousLeg');

  @override
  Future<void> setRoute(MPRoute? route) =>
    directionsRendererMethodChannel
        .invokeMethod('DRE_setRoute', {"route": jsonEncode(route)});

  @override
  Future<void> setAnimatedPolyline(bool animated, bool repeating, int durationMs) =>
    directionsRendererMethodChannel.invokeMethod('DRE_setAnimatedPolyline', {
      "animated": animated,
      "repeating": repeating,
      "durationMs": durationMs
    });

  @override
  Future<void> setPolyLineColors(String foreground, String background) =>
    directionsRendererMethodChannel.invokeMethod('DRE_setPolyLineColors',
        {"foreground": foreground, "background": background});

  @override
  Future<void> selectLegIndex(int legIndex) =>
    directionsRendererMethodChannel
        .invokeMethod('DRE_selectLegIndex', {"legIndex": legIndex});

  @override
  Future<int?> getSelectedLegFloorIndex() =>
    directionsRendererMethodChannel
        .invokeMethod<int>('DRE_getSelectedLegFloorIndex');

  @override
  Future<void> setCameraAnimationDuration(int durationMs) =>
    directionsRendererMethodChannel
        .invokeMethod('DRE_setCameraAnimationDuration', {"durationMs": durationMs});

  @override
  Future<void> setCameraViewFitMode(MPCameraViewFitMode mpCameraViewFitMode) {
    late int cameraFitMode;
    switch (mpCameraViewFitMode) {
      case MPCameraViewFitMode.northAligned:
        cameraFitMode = 0;
        break;
      case MPCameraViewFitMode.firstStepAligned:
        cameraFitMode = 1;
        break;
      case MPCameraViewFitMode.startToEndAligned:
        cameraFitMode = 2;
        break;
    }
    return directionsRendererMethodChannel
        .invokeMethod('DRE_setCameraViewFitMode', {"cameraFitMode": cameraFitMode});
  }

  @override
  Future<void> setOnLegSelectedListener(OnLegSelectedListener? onLegSelectedListener) {
    _onLegSelectedListener = onLegSelectedListener;
    return directionsRendererMethodChannel.invokeMethod('DRE_setOnLegSelectedListener');
  }

  @override
  Future<void> useContentOfNearbyLocations() {
    // TODO: implement useContentOfNearbyLocations
    return Future(() {});
  }
}
