part of 'package:mapsindoors_platform_interface/platform_library.dart';


@immutable
class DynamicObjectId {
  /// Creates an immutable object representing among [MapsIndoors] Ts.
  const DynamicObjectId(this.value);

  /// The value of the id.
  final String value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DynamicObjectId && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return '${objectRuntimeType(this, 'MapsObjectId')}($value)';
  }
}

abstract class DynamicObject<T extends DynamicObjectId> {
  T get id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DynamicObject && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

abstract class MapsIndoorsObject {
  Map<String, dynamic> toJson();
  String _jsonEncode() => jsonEncode(toJson());
}

/// for use with MapsIndoors objects
List<T> convertMIList<T>(List<dynamic> data, T? Function(dynamic) fromJson) {
  final List<T> list = List.empty(growable: true);
  for (final item in data) {
    final T? convert = fromJson(item);
    if (convert != null) {
      list.add(convert);
    }
  }
  return list;
}

String convertMIListToJson(List<MapsIndoorsObject> objects) {
  return jsonEncode(List.from(objects.map((e) => e.toJson())));
}

/// for use with dart default types
List<T> convertJsonArray<T>(List<dynamic> json) {
  return json.map((e) => e as T).toList();
}

/// for use with dart default types
List<List<T>> convertJson2dArray<T>(List<dynamic> json) {
  return json.map((e) {
    if (e is List<dynamic>) {
      return convertJsonArray<T>(e);
    } else {
      return [] as List<T>;
    }
  }).toList();
}

/// for use with dart default types
List<List<List<T>>> convertJson3dArray<T>(List<dynamic> json) {
  return json.map((e) {
    if (e is List<dynamic>) {
      return convertJson2dArray<T>(e);
    } else {
      return [] as List<List<T>>;
    }
  }).toList();
}

/// for use with dart default types
List<List<List<List<T>>>> convertJson4dArray<T>(List<dynamic> json) {
  return json.map((e) {
    if (e is List<dynamic>) {
      return convertJson3dArray<T>(e);
    } else {
      return [] as List<List<List<T>>>;
    }
  }).toList();
}