part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A collection of user role objects fetched from [MapsIndoors]. Uses [MPUserRole.id] as key
class MPUserRoleCollection extends MPCollection<MPUserRole> {
  /// Attempts to build a [MPUserRoleCollection] from a JSON object, this method will decode the object if needed
  static MPUserRoleCollection? fromJson(json) => json != null && json != "null"
      ? MPUserRoleCollection._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPUserRoleCollection._fromJson(data) : super._() {
    List<MPUserRole> userroles =
        convertMIList<MPUserRole>(data, (p0) => MPUserRole.fromJson(p0));
    userroles.forEach((role) => _map[role.id] = role);
  }
}
