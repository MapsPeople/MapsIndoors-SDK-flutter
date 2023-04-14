part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when MapsIndoors is ready for use
abstract class OnMapsIndoorsReadyListener {
  /// If [error] is null, MapsIndoors is ready for use
  void onMapsIndoorsReady(MPError? error);
}