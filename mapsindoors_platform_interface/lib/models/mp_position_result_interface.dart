part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Interface to deliver a position result to the MapsIndoors SDK
abstract class MPPositionResultInterface extends MapsIndoorsObject {
  /// The position in world space
  MPPoint? get point;
  /// The floor the position is on
  int? get floorIndex;
  /// The [bearing] the position is pointing
  num? get bearing;
  /// The [accuracy] of the position in meters
  num? get accuracy;
  /// What position provider delivered the position result
  MPPositionProviderInterface get provider;

  /// Converts the [MPPositionResultInterface] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {
      "point": point,
      "floorIndex": floorIndex,
      "bearing": bearing,
      "accuracy": accuracy,
      "providerName":provider.name
    };
  }
}