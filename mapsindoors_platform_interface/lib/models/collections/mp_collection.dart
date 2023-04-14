part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A collection that offers simple getter logic
class MPCollection<T> {
  late Map<String, T> _map;

  MPCollection._() {
    this._map = new Map();
  }

  /// Fetch all elements from this collection as a list
  List<T> getAll() {
    return List.from(_map.values);
  }

  /// Fetch an element by its identifier
  T? getById(String id) {
    return _map[id];
  }

  /// Get the number of elements in this collection
  int get size => _map.length;
}
