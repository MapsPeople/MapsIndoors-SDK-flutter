part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Class to hold [height] and [width] information for an icon
class MPIconSize extends MapsIndoorsObject {
  late final int height;
  late final int width;

  /// Construct a size from a [height] and a [width]
  MPIconSize({required this.height, required this.width});

  /// Attempts to build a [MPIconSize] from a JSON object, this method will decode the object if needed
  static MPIconSize? fromJson(json) => json != null && json != "null"
      ? MPIconSize._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPIconSize._fromJson(data) {
    height = data["height"];
    width = data["width"];
  }

  /// Converts the [MPIconSize] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {"width": width, "height": height};
  }
}
