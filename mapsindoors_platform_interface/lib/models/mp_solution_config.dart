part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An object that governs solution level settings such as:
/// <ul>
///     <li>Marker clustering</li>
///     <li>Marker collision handling</li>
///     <li>Main Display Rule</li>
///     <li>[MPSettings3D]</li>
/// </ul>
class MPSolutionConfig {
  /// Settings related to 3D rendering
  late final MPSettings3D settings3D;
  late MPCollisionHandling? _collisionHandling;
  late bool? _enableClustering;

  /// Attempts to build a [MPSolutionConfig] from a JSON object, this method will decode the object if needed
  static MPSolutionConfig? fromJson(json) => json != null && json != "null"
      ? MPSolutionConfig._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPSolutionConfig._fromJson(data) {
    settings3D = MPSettings3D.fromJson(data["settings3D"])!;
    if (data["collisionHandling"] is int) {
    } else {
      _collisionHandling = _collisionHandling =
          MPCollisionHandling.fromValue(int.parse(data["collisionHandling"]));
    }

    _enableClustering = data["enableClustering"];
  }

  /// Get whether clustering is enabled
  bool? get enableClustering => _enableClustering;

  /// Set whether clustering is enabled
  set enableClustering(bool? enable) {
    if (enable != null) {
      _enableClustering = enable;
      UtilPlatform.instance.setEnableClustering(enable);
    }
  }

  /// Get the type of [collisionHandling] that is enabled
  MPCollisionHandling? get collisionHandling => _collisionHandling;

  /// Set the type of [collisionHandling] that is enabled
  set collisionHandling(MPCollisionHandling? handling) {
    if (handling != null) {
      _collisionHandling = handling;
      UtilPlatform.instance.setCollisionHandling(handling);
    }
  }
}
