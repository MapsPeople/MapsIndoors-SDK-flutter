part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when a markers infowindow is clicked
abstract class OnMarkerInfoWindowClickListener {
  /// When the infowindow is clicked, the corresponding [MPLocation]' [locationId] is supplied
  void onInfoWindowClick(String locationId);
}
