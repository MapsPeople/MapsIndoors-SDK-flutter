part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A unique identifier for buildings
@immutable
class MPBuildingId extends DynamicObjectId {
  const MPBuildingId(String value) : super(value);
}

/// A MapsIndoors geographical entity. A [MPBuilding] is contained within a [MPVenue]
/// and contains a number of [MPFloor]s.
class MPBuilding extends MPEntity<MPBuildingId> {
  late final MPBuildingId _id;
  String? _administrativeId;
  String? _externalId;
  String? _venueId;
  MPPoint? _anchor;
  MPBuildingInfo? _buildingInfo;
  MPPolygon? _geometry;
  Map<int, MPFloor>? _floors;
  int? _defaultFloor;
  String? _address;
  int? _status;

  /// Attempts to build a [MPBuilding] from a JSON object, this method will decode the object if needed
  static MPBuilding? fromJson(json) => json != null && json != "null"
      ? MPBuilding._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPBuilding._fromJson(data) {
    _id = MPBuildingId(data["id"]);
    _administrativeId = data["administrativeId"];
    _externalId = data["externalId"];
    _venueId = data["venueId"];
    _anchor = MPPoint.fromJson(data["anchor"]);
    _buildingInfo = MPBuildingInfo.fromJson(data["buildingInfo"]);
    _geometry = MPPolygon.fromJson(data["geometry"]);
    _floors = (data["floors"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(int.parse(key), MPFloor.fromJson(value)!));
    for (var floor in _floors!.entries) {
      floor.value.buildingId = _id.value;
    }
    _defaultFloor = data["defaultFloor"];
    _address = data["address"];
    _status = data["status"];
  }

  /// Get the building's [id]
  @override
  MPBuildingId get id => _id;

  /// Get the building's [bounds]
  @override
  MPBounds? get bounds => _geometry?.bounds;

  /// Inherited from [MPEntity], a building's [geometry] is never a [MPPoint]
  @override
  bool isPoint() => false;

  /// Get the [position] of the building, this will correspond to the building's anchor point
  @override
  MPPoint get position => _anchor!;

  /// Get the building's [id] value
  String get buildingId => _id.value;

  /// Get the building's administrative id
  String get administrativeId => _administrativeId!;

  /// Get the building's external id
  String get externalId => _externalId!;

  /// Get the id of the venue this building is in
  String get venueId => _venueId!;

  /// Get the building's [name]
  String get name => _buildingInfo!.name;

  /// Get the building's [address]
  String get address => _address ?? "";

  /// Get a list of [aliases] for the building
  List<String> get aliases => _buildingInfo!.aliases!;

  /// Get the building's [geometry]
  MPPolygon get geometry => _geometry!;

  /// Get the number of [MPFloor]s in the building
  int get floorCount => _floors!.length;

  /// Get a list of the floors in the building
  List<MPFloor> get floors {
    List<MPFloor> list = List.from(_floors!.values);
    list.sort((a, b) => a.compareTo(b));
    return list;
  }

  /// Get the default floor index
  int get initialFloorIndex => _defaultFloor ?? floors.first._floorIndex ?? 0;

  /// Check whether the building contains a floor with the [floorIndex]
  bool hasFloorIndex(int floorIndex) => _floors!.containsKey(floorIndex);

  /// Fetch a floor by providing its [floorIndex]
  MPFloor? getFloorByIndex(int floorIndex) => _floors?[floorIndex];

  /// Check whether the building's [geometry] [contains] the [point]
  Future<bool?> contains(MPPoint point) async =>
      await _geometry?.contains(point);

  /// Fetch a custom field saved on the building
  MPDataField? getField(String? key) => _buildingInfo?.fields[key];

  /// Converts the [MPBuilding] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": _id.value,
      "administrativeId": _administrativeId,
      "externalId": _externalId,
      "venueId": _venueId,
      "anchor": _anchor,
      "buildingInfo": _buildingInfo,
      "geometry": _geometry,
      "floors": _floors
          ?.map((key, value) => MapEntry(key.toString(), value.toJson())),
      "defaultFloor": _defaultFloor,
      "address": _address,
      "status": _status
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MPBuilding && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
