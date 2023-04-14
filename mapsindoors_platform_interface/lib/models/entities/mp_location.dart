part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A unique identifier for locations
@immutable
class MPLocationId extends DynamicObjectId {
  const MPLocationId(String value) : super(value);
}

/// A MapsIndoors geographical entity. A [MPLocation] can exist anywhere,
/// but it is usually only used inside [MPVenue]s and [MPBuilding]s.
class MPLocation extends MPEntity<MPLocationId> {
  late MPLocationId _id;
  MPGeometry? _geometry;
  MPBounds? _bounds;
  List<String>? _restrictions;
  MPPropertyData? _properties;
  MPPoint? _point;

  /// Attempts to build a [MPLocation] from a JSON object, this method will decode the object if needed
  static MPLocation? fromJson(json) => json != null && json != "null"
      ? MPLocation._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPLocation._fromJson(data) {
    _id = MPLocationId(data["id"]);
    if (data["geometry"] != null) {
      final geo = data["geometry"];
      switch (geo["type"]) {
        case MPGeometry.point:
          _geometry = MPPoint.fromJson(geo);
          break;
        case MPGeometry.polygon:
          _geometry = MPPolygon.fromJson(geo);
          break;
        case MPGeometry.multiPolygon:
          _geometry = MPMultiPolygon.fromJson(geo);
          break;
      }
    }
    if (Platform.isIOS) {
      if (data["point"] != null) {
        _point = MPPoint.fromJson(data["point"]);
      }
    }
    if (data["restrictions"] != null) {
      _restrictions = convertJsonArray<String>(data["restrictions"]);
    }
    _properties = MPPropertyData.fromJson(data["properties"]);
  }

  /// Get the location's [bounds]
  @override
  MPBounds get bounds {
    if (_bounds != null) {
      return _bounds!;
    } else {
      switch (_geometry!.runtimeType) {
        case MPPolygon:
          return _bounds ??= (_geometry as MPPolygon).bounds;
        case MPMultiPolygon:
          return _bounds ??= (_geometry as MPMultiPolygon).bounds;
        default:
          return _bounds ??= MPBounds(northeast: position, southwest: position);
      }
    }
  }

  /// Inherited from [MPEntity], checks whether the location's [geometry] is a [MPPoint]
  @override
  bool isPoint() => _geometry is MPPoint;

  /// Get the location's [position], this is usually the location's anchor point
  @override
  MPPoint get position =>
      _properties?._anchor ??
      MPPoint.withCoordinates(latitude: 0, longitude: 0);

  /// Converts the [MPLocation] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() => {"id": id.value};

  /// Get the location's [id]
  @override
  MPLocationId get id => _id;

  /// Get the location's [id] value
  String get locationId => _id.value;

  /// Get the location's [point]
  MPPoint get point => _point ??= _calcPoint();

  MPPoint _calcPoint() {
    if (_geometry == null) {
      return MPPoint();
    } else {
      final pt = MPPoint.copy(_geometry!.position);
      pt.floorIndex = floorIndex;
      return pt;
    }
  }

  // Get the location's [geometry]
  // This is currently unused
  //MPGeometry get geometry => _geometry!;

  /// Get the location's [name]
  String get name => _properties!.name;

  /// Get a list of [aliases] for the location
  List<String>? get aliases => _properties?._aliases;

  /// Get a list of [categories] the location is contained in
  List<String>? get categories {
    final categoryMap = _properties?._categories?.entries;
    return categoryMap != null ? List.from(categoryMap) : null;
  }

  /// Get the location's [floorIndex]
  int get floorIndex => _properties!._floorIndex!;

  /// Get the name of the [MPFloor] the location is on
  String? get floorName => _properties?._floorName;

  /// Get the name of the [MPBuilding] the location is in
  String? get buildingName => _properties?._building;

  /// Get the name of the [MPVenue] the location is in
  String? get venueName => _properties?._venue;

  /// Get the name of the location's type
  String? get typeName => _properties?._type;

  /// Get the location's [description]
  String? get description => _properties?._description;

  /// Get the location's external id
  String get externalId => _properties!._externalId!;

  /// Get the time (epoch) the location is active from
  int? get activeFrom => _properties?._activeFrom;

  /// Get the time (epoch) the location is active to
  int? get activeTo => _properties?._activeTo;

  /// Get the URL for the location's image
  String? get imageUrl => _properties?._imageUrl;

  /// Get the location's [restrictions]
  List<String>? get restrictions => _restrictions;

  /// Chech whether this location is bookable, this only checks if the location is allowed to be booked
  bool isBookable() => _properties?._bookable ?? false;

  /// Gets the location's [MPLocationType] [baseType]
  MPLocationType get baseType {
    switch (_properties?._type) {
      case "area":
        return MPLocationType.area;
      case "venue":
        return MPLocationType.venue;
      case "building":
        return MPLocationType.building;
      case "room":
        return MPLocationType.room;
      case "floor":
        return MPLocationType.floor;
      case "asset":
        return MPLocationType.asset;
      case "poi":
      default:
        return MPLocationType.poi;
    }
  }

  /// Fetch a property from the location with a [MPLocationPropertyNames] [key]
  Object? getProperty(MPLocationPropertyNames key) {
    switch (key) {
      case MPLocationPropertyNames.name:
        return _properties?.name;
      case MPLocationPropertyNames.aliases:
        return _properties?._aliases;
      case MPLocationPropertyNames.categories:
        return _properties?._categories;
      case MPLocationPropertyNames.floor:
        return _properties?._floorIndex;
      case MPLocationPropertyNames.floorName:
        return _properties?._floorName;
      case MPLocationPropertyNames.building:
        return _properties?._building;
      case MPLocationPropertyNames.venue:
        return _properties?._venue;
      case MPLocationPropertyNames.type:
        return _properties?._type;
      case MPLocationPropertyNames.description:
        return _properties?._description;
      case MPLocationPropertyNames.roomId:
      case MPLocationPropertyNames.externalId:
        return _properties?._externalId;
      case MPLocationPropertyNames.activeFrom:
        return _properties?._activeFrom;
      case MPLocationPropertyNames.activeTo:
        return _properties?._activeTo;
      case MPLocationPropertyNames.contact:
        return _properties?._contact;
      case MPLocationPropertyNames.fields:
        return _properties?._fields;
      case MPLocationPropertyNames.imageURL:
        return _properties?._imageUrl;
      case MPLocationPropertyNames.locationType:
        return _properties?._locationType;
      case MPLocationPropertyNames.anchor:
        return _properties?._anchor;
      case MPLocationPropertyNames.status:
        return _properties?._status;
      case MPLocationPropertyNames.bookable:
        return _properties?._bookable;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MPLocation && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
