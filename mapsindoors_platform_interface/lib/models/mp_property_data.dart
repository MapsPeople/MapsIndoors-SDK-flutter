part of 'package:mapsindoors_platform_interface/platform_library.dart';

class MPPropertyData extends MapsIndoorsObject {
  String? _name;
  List<String>? _aliases;
  Map<String, String>? _categories;
  int? _floorIndex;
  String? _floorName;
  String? _building;
  String? _venue;
  //DisplayRule? _displayRule; // has been removed due to the nature of this display rule being an immutable display rule which cannot be viewed
  String? _type;
  String? _description;
  String? _externalId;
  int? _activeFrom;
  int? _activeTo;
  Map<String, MPDataField>? _contact;
  Map<String, MPDataField>? _fields;
  String? _imageUrl;
  String? _locationType;
  MPPoint? _anchor;
  bool? _bookable;
  int? _status;

  static MPPropertyData? fromJson(json) => json != null && json != "null"
      ? MPPropertyData._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPPropertyData._fromJson(data) {
    _name = data["name"];
    if (data["aliases"] != null) {
      _aliases = convertJsonArray(data["aliases"]);
    }
    if (data["categories"] != null) {
      _categories = (data["categories"] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toString()));
    }
    _floorIndex = int.tryParse(data["floor"]);
    _floorName = data["floorName"];
    _building = data["building"];
    _venue = data["venue"];
    //_displayRule = DisplayRuledata["displayRule"];
    _type = data["type"];
    _description = data["description"];
    _externalId = data["externalId"];
    _activeFrom = data["activeFrom"];
    _activeTo = data["activeTo"];
    if (data["contact"] != null) {
      _contact = (data["contact"] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, MPDataField.fromJson(value)!));
    }
    if (data["fields"] != null) {
      _fields = (data["fields"] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, MPDataField.fromJson(value)!));
    }
    _imageUrl = data["imageURL"];
    _locationType = data["locationType"];
    _anchor = MPPoint.fromJson(data["anchor"]);
    _bookable = data["bookable"];
    _status = data["status"];
  }

  String get name {
    return _name!.replaceAll("\\n", "n");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": _name,
      "aliases": _aliases,
      "categories": _categories,
      "floor": _floorIndex.toString(),
      "floorName": _floorName,
      "building": _building,
      "venue": _venue,
      "type": _type,
      "description": _description,
      "externalId": _externalId,
      "activeFrom": _activeFrom,
      "activeTo": _activeTo,
      "contact": _contact,
      "fields": _fields,
      "imageURL": _imageUrl,
      "locationType": _locationType,
      "anchor": _anchor,
      "bookable": _bookable,
      "status": _status
    };
  }
}
