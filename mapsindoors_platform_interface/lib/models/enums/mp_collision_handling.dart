part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Describes how the SDK should handle markers and labels overlapping with other markers and labels
enum MPCollisionHandling {
  allowOverlap(0),
  removeLabelFirst(1),
  removeIconFirst(2),
  removeIconAndLabel(3);

  /// The integer representation of this handling preset
  final int value;
  const MPCollisionHandling(this.value);

  dynamic toJson() => value;

  /// Parses the integer value of the enum
  static MPCollisionHandling fromValue(int value) {
    switch (value) {
      case 0:
        return MPCollisionHandling.allowOverlap;
      case 1:
        return MPCollisionHandling.removeLabelFirst;
      case 2:
        return MPCollisionHandling.removeIconFirst;
      case 3:
        return MPCollisionHandling.removeIconAndLabel;
      default:
        throw ArgumentError(
            "A MPCollisionHandling scheme does not exist for the value $value");
    }
  }
}
