part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when the map is clicked
abstract class OnMapClickListener {
  /// When the map is clicked, the [point] of the click, as well as any nearby [MPLocation]s are supplied
  void onMapClick(MPPoint point, List<MPLocation>? locations);
}