part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when a venue is found within the camera bounds
abstract class OnVenueFoundAtCameraTargetListener {
    /// When a [venue] is found
  void onVenueFoundAtCameraTarget(MPVenue? venue);
}
