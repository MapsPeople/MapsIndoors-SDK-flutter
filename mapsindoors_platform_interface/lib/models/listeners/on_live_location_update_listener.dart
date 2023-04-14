part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked when a location receives a livedata update
abstract class OnLiveLocationUpdateListener {
  /// When a [location] recieves an update for the subscribed livdata domain
  void onLocationReceivedLiveUpdate(MPLocation location);
}
