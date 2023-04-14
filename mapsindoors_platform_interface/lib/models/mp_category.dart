part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A categorisation for MapsIndoors objects
class MPCategory {
  /// The category's [key]
  late final String key;
  /// The category's [value]
  late final String value;
  /// The category's [fields]
  late final Map<String, MPDataField>? fields;

  /// Attempts to build a [MPCategory] from a JSON object, this method will decode the object if needed
  static MPCategory? fromJson(json) => json != null && json != "null"
      ? MPCategory._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPCategory._fromJson(data) {
    key = data["key"];
    value = data["value"];
    fields = (data["fields"] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(key, MPDataField.fromJson(value)!));
  }
}
