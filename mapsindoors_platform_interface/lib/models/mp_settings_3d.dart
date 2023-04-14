part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An object that governs layer settings for 3D features.
/// 
/// Can be aquired with [MPSolutionConfig.settings3D]
class MPSettings3D {
  late final num? _extrusionOpacity;
  late final num? _wallOpacity;

  /// Attempts to build a [MPSettings3D] from a JSON object, this method will decode the object if needed
  static MPSettings3D? fromJson(json) => json != null && json != "null"
      ? MPSettings3D._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPSettings3D._fromJson(data) {
    _extrusionOpacity = data["extrusionOpacity"];
    _wallOpacity = data["wallOpacity"];
  }

  /// Get the opacity of extruded rooms
  num? get extrusionOpacity => _extrusionOpacity;

  /// Get the opacity of extruded walls
  num? get wallOpacity => _wallOpacity;

  /// Set the opacity of extruded rooms
  set extrusionOpacity(num? opacity) {
    if (opacity != null) {
      _extrusionOpacity = opacity;
      UtilPlatform.instance.setExtrusionOpacity(opacity);
    }
  }

  /// Set the opacity of extruded walls
  set wallOpacity(num? opacity) {
    if (opacity != null) {
      _wallOpacity = opacity;
      UtilPlatform.instance.setWallOpacity(opacity);
    }
  }
}
