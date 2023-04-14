part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A [MPDataField] contains a single field [value] with descriptive 
/// [text] and a [type] that describes the type of the [value] (eg. text or number)
class MPDataField extends MapsIndoorsObject {
  /// The [value] of the field
  late final String? value;
  /// The descriptive [text] for the field
  late final String? text;
  /// The [type] of the [value]
  late final String? type;

  /// Attempts to build a [MPDataField] from a JSON object, this method will decode the object if needed
  static MPDataField? fromJson(json) => json != null && json != "null"
      ? MPDataField._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPDataField._fromJson(data) {
    value = data["value"];
    text = data["text"];
    type = data["type"];
  }

  /// Converts the [MPDataField] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() => {"value": value, "text": text, "type": type};
}
