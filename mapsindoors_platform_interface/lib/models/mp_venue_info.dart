part of 'package:mapsindoors_platform_interface/platform_library.dart';

class MPVenueInfo extends MapsIndoorsObject {
  String? _name;
  List<String>? _aliases;
  String? _language;
  Map<String, MPDataField>? _fields;

  static MPVenueInfo? fromJson(json) => json != null && json != "null"
      ? MPVenueInfo._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPVenueInfo._fromJson(data) {
    _name = data["name"];
    if (data["aliases"] != null) {
      _aliases = convertJsonArray<String>(data["aliases"]);
    }
    _language = data["language"];
    _fields = (data["fields"] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(key, MPDataField.fromJson(value)!));
  }

  @override
  Map<String, dynamic> toJson() => {
        "name": _name,
        "aliases": _aliases,
        "language": _language,
        "fields": _fields
      };
}
