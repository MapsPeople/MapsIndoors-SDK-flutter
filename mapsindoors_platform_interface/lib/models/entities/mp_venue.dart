part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A unique identifier for venues
@immutable
class MPVenueId extends DynamicObjectId {
  const MPVenueId(String value) : super(value);
}

/// A MapsIndoors geographical entity. A [MPVenue] can exist anywhere,
/// and it can contain a number of [MPBuilding]s and [MPLocation]s.
class MPVenue extends MPEntity<MPVenueId> {
  late MPVenueId _id;
  String? _graphId;
  String? _administrativeId;
  String? _tilesUrl;
  List<MPMapStyle>? _mapStyles;
  MPPolygon? _geometry;
  int? _defaultFloor;
  MPVenueInfo? _venueInfo;
  MPPoint? _anchor;
  List<MPPoint>? _entryPoints;
  String? _externalId;
  int? _status;

  /// Attempts to build a [MPVenue] from a JSON object, this method will decode the object if needed
  static MPVenue? fromJson(json) => json != null && json != "null"
      ? MPVenue._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPVenue._fromJson(data) {
    _id = MPVenueId(data["id"]);
    _graphId = data["graphId"];
    _administrativeId = data["name"];
    _tilesUrl = data["tilesUrl"];
    _geometry = MPPolygon.fromJson(data["geometry"]);
    _defaultFloor = data["defaultFloor"];
    _venueInfo = MPVenueInfo.fromJson(data["venueInfo"]);
    _anchor = MPPoint.fromJson(data["anchor"]);
    _externalId = data["externalId"];
    _status = data["status"];
    _mapStyles = convertMIList<MPMapStyle>(
        data["styles"], (p0) => MPMapStyle.fromJson(p0));
    _entryPoints = convertMIList<MPPoint>(
        data["entryPoints"], ((p0) => MPPoint.fromJson(p0)));
  }

  /// Converts the [MPVenue] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": _id.value,
      "graphId": _graphId,
      "administrativeId": _administrativeId,
      "tilesUrl": _tilesUrl,
      "styles": _mapStyles,
      "geometry": _geometry,
      "defaultFloor": _defaultFloor,
      "venueInfo": _venueInfo,
      "anchor": _anchor,
      "entryPoints": _entryPoints,
      "externalId": _externalId,
      "status": _status
    };
  }

  /// Get the [position] of the venue, this will correspond to the venue's anchor point
  @override
  MPPoint get position => _anchor!;

  /// Get the venue's [geometry]
  MPPolygon get geometry => _geometry!;

  /// Get the venue's [bounds]
  @override
  MPBounds? get bounds => _geometry?.bounds;

  /// Get the venue's [id]
  @override
  MPVenueId get id => _id;

  /// Get the venue's external id
  String get externalId => _externalId!;

  /// Get the venue's graph id
  String? get graphId => _graphId;

  /// Get the venue's URL for tiles
  String get tilesUrl => _tilesUrl!;

  /// Get the venue's [name]
  String? get name => _venueInfo?._name;

  /// Get the venue's administrative id
  String get administrativeId => _administrativeId!;

  /// Get the venue's information bundle
  MPVenueInfo get venueInfo => _venueInfo!;

  /// Get the venue's map styles
  List<MPMapStyle> get mapStyles => _mapStyles ?? [];

  /// Get the venue's default mapstyle
  MPMapStyle? get defaultMapStyle => _mapStyles?[0];

  /// Get a list of entry points for the venue
  List<MPPoint> get entryPoints => _entryPoints ?? [];

  /// Get the venue's default floor
  int get defaultFloor => _defaultFloor!;

  /// Fetch a field from the venue
  MPDataField? getField(String? key) => _venueInfo?._fields?[key];

  /// Inherited from [MPEntity], a venue's [geometry] is never a [MPPoint]
  @override
  bool isPoint() => false;

  /// Check whether a given [mapstyle] is valid for the venue
  bool isMapStyleValid(MPMapStyle mapstyle) {
    if (_mapStyles == null) {
      return false;
    }
    for (var style in _mapStyles!) {
      if (style == mapstyle) {
        return true;
      }
    }
    return false;
  }

  /// Check whether the venue has a valid routing graph
  Future<bool?> hasGraph() async {
    if (_graphId == null) {
      return false;
    }
    return await UtilPlatform.instance.venueHasGraph(_id.value);
  }

  /// Check whether the venue contains a [point]
  Future<bool?> contains(MPPoint point) async =>
      await UtilPlatform.instance.geometryIsInside(_geometry!, point);


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MPVenue && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
