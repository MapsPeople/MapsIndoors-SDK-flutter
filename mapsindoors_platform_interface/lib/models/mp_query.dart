part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A collection of query parameters used to query MapsIndoors
class MPQuery extends MapsIndoorsObject {
  static MPQueryBuilder builder() => MPQueryBuilder();

  /// The queried text (search text)
  final String? query;
  /// The query is restricted to entities near this point
  final MPPoint? near;
  /// A list of properties for this query
  final List<String>? queryProperties;

  MPQuery._(this.query, this.near, this.queryProperties);

    /// Converts the [MPQuery] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {
      "query": query,
      "near": near?.toJson(),
      "queryProperties": queryProperties,
    };
  }
}

/// A builder for [MPQuery]
class MPQueryBuilder {
  String? _query;
  MPPoint? _near;
  List<String>? _queryProperties;

  /// Set the [query] text
  MPQueryBuilder setQuery(String query) {
    _query = query;
    return this;
  }

  /// Set the point where the queried target is [near]
  MPQueryBuilder setNear(MPPoint near) {
    _near = near;
    return this;
  }

  /// Set the coordinates where the queried target is near
  MPQueryBuilder setNearWithCoordinates({required num longitude, required num latitude}) {
    _near = MPPoint.withCoordinates(latitude: latitude, longitude: longitude);
    return this;
  }

  /// Set a list of query [properties], see [MPLocationPropertyNames]
  MPQueryBuilder setQueryProperties(List<String> properties) {
    _queryProperties = List.from(properties);
    return this;
  }

  /// Add a single query [property], see [MPLocationPropertyNames]
  MPQueryBuilder addQueryProperty(String property) {
    _queryProperties ??= List.empty(growable: true);
    _queryProperties!.add(property);
    return this;
  }

  /// Construct a [MPQuery]
  MPQuery build() {
    return MPQuery._(_query, _near, _queryProperties);
  }
}
