part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Interface for added a position provider to the SDK
abstract class MPPositionProviderInterface {
  /// Add a [listener] to the position provider 
  /// 
  /// Invoke the [listener] when a new position has been received
  void addOnPositionUpdateListener(OnPositionUpdateListener listener);
  /// Remove a [listener]
  void removeOnPositionUpdateListener(OnPositionUpdateListener listener);

  /// Invoked when the latest valid position is needed
  MPPositionResultInterface? getLatestPosition();

  /// The name of the position provider, used to identify it
  String get name;
}