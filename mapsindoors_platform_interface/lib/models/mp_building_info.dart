part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A collection of information about a [MPBuilding]
class MPBuildingInfo extends MapsIndoorsObject {
  String? _name;
  List<String>? _aliases;
  Map<String, MPDataField>? _fields;

  /// Attempts to build a [MPBuildingInfo] from a JSON object, this method will decode the object if needed
  static MPBuildingInfo? fromJson(json) => json != null && json != "null"
      ? MPBuildingInfo._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPBuildingInfo._fromJson(data) {
    _name = data["name"];
    _aliases = data["aliases"] != null
        ? convertJsonArray<String>(data["aliases"])
        : null;
    _fields = data["fields"] != null
        ? (data?["fields"] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, MPDataField.fromJson(value)!))
        : null;
  }

  /// Converts the [MPBuilding] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() =>
      {"name": _name, "aliases": _aliases, "fields": _fields};

  /// The [MPBuilding]'s [name]
  String get name => _name!;

  /// The [MPBuilding]'s [aliases]
  List<String>? get aliases => _aliases;

  /// Fetch a [MPDataField] with its corresponding [key]
  MPDataField? getField(String? key) {
    return _fields?[key];
  }

  /// Get all [fields] for the [MPBuilding]
  Map<String, MPDataField> get fields => _fields ?? {};
}
