part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A User Role that allows certain parts of the data to be viewed
class MPUserRole extends MapsIndoorsObject {
  /// The [id] of the user role
  late final String id;
  /// The [name] of the user role
  late final String name;


  /// Attempts to build a [MPUserRole] from a JSON object, this method will decode the object if needed
  static MPUserRole? fromJson(json) => json != null && json != "null"
      ? MPUserRole._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPUserRole._fromJson(data) {
    id = data["id"];
    name = data["name"];
  }

  @override
  bool operator ==(Object other) =>
      other is MPUserRole && 
      other.runtimeType == runtimeType &&
      name.toLowerCase() == other.name.toLowerCase();

  @override
  int get hashCode => Object.hash(id, name);

  @override
  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
