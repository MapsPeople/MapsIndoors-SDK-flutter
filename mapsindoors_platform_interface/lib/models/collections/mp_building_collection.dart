part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A collection of building objects fetched from [MapsIndoors]. Uses [MPBuilding.id] as key
class MPBuildingCollection extends MPCollection<MPBuilding> {
  late Map<String, MPBuilding> _adminIdMap;

  /// Attempts to build a [MPBuildingCollection] from a JSON object, this method will decode the object if needed
  static MPBuildingCollection? fromJson(json) => json != null && json != "null"
      ? MPBuildingCollection._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPBuildingCollection._fromJson(data) : super._() {
    _adminIdMap = new Map();
    List<MPBuilding> buildings = convertMIList<MPBuilding>(data, (p0) => MPBuilding.fromJson(p0));
    buildings.forEach((building) {
      _map[building.id.value] = building;
      _adminIdMap[building.administrativeId] = building;
    });
  }

  /// Fetch a building by its administrative [id] 
  MPBuilding? getBuildingByAdminId(String id) {
    return this._adminIdMap[id];
  }
}
