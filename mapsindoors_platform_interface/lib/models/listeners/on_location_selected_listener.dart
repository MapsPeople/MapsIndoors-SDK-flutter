part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when a [MPLocation] is selected
abstract class OnLocationSelectedListener {
  /// When a [location] is selected, will be null if no [location] is selected
  void onLocationSelected(MPLocation? location);
}