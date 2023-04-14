part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A collection of category objects fetched from [MapsIndoors]. Uses [MPCategory.key] as key
class MPCategoryCollection extends MPCollection<MPCategory> {
  /// Attempts to build a [MPCategoryCollection] from a JSON object, this method will decode the object if needed
  static MPCategoryCollection? fromJson(json) => json != null && json != "null"
      ? MPCategoryCollection._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPCategoryCollection._fromJson(data) : super._() {
    List<MPCategory> categories = convertMIList<MPCategory>(data, (p0) => MPCategory.fromJson(p0));
    categories.forEach((category) => _map[category.key] = category);
  }

  /// Fetch the [MPCategory.value] of a [MPCategory] directly from the collection
  String? getValue(String key) {
    return this.getById(key)?.value;
  }

  /// Fetch the [MPCategory.fields] of a [MPCategory] directly from the collection
  Map<String, MPDataField>? getFields(String key) {
    return this.getById(key)?.fields;
  }
}