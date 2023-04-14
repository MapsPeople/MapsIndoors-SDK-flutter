part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A collection of venue objects fetched from [MapsIndoors]. Uses [MPVenue.id] as key
class MPVenueCollection extends MPCollection<MPVenue> {
  late Map<String, MPVenue> _adminIdMap;

  /// Attempts to build a [MPVenueCollection] from a JSON object, this method will decode the object if needed
  static MPVenueCollection? fromJson(json) => json != null && json != "null"
      ? MPVenueCollection._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPVenueCollection._fromJson(data) : super._() {
    _adminIdMap = new Map();
    List<MPVenue> venues =
        convertMIList<MPVenue>(data, (p0) => MPVenue.fromJson(p0));
    venues.forEach((venue) {
      _map[venue.id.value] = venue;
      _adminIdMap[venue.administrativeId] = venue;
    });
  }

  /// Fetch a venue by its administrative [id]
  MPVenue? getVenueByAdminId(String id) {
    return this._adminIdMap[id];
  }
}
