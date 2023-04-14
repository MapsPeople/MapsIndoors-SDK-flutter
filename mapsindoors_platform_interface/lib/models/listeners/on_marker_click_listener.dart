part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when a [MPLocation] marker is clicked on the map
abstract class OnMarkerClickListener {
  /// When a marker is clicked, the associated [MPLocation.id] is returned
  void onMarkerClick(String locationId);
}
