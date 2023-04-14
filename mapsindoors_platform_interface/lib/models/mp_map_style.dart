part of 'package:mapsindoors_platform_interface/platform_library.dart';

class MPMapStyle extends MapsIndoorsObject {
  /// The folder the style is saved in
  late String folder;
  /// The name of the style
  late String displayName;

  /// Attempts to build a [MPMapStyle] from a JSON object, this method will decode the object if needed
    static MPMapStyle? fromJson(json) => json != null && json != "null"
      ? MPMapStyle._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPMapStyle._fromJson(data) {
    folder = data["folder"];
    displayName = data["displayName"];
  }

  /// Converts the [MPMapStyle] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {"folder": folder, "displayName": displayName};
  }

  @override
  bool operator ==(Object other) => (other is MPMapStyle &&
      other.runtimeType == runtimeType &&
      other.folder.toLowerCase() == folder.toLowerCase() &&
      other.displayName.toLowerCase() == displayName.toLowerCase());

  @override
  int get hashCode =>
      (folder.toLowerCase() + displayName.toLowerCase()).hashCode;
}
