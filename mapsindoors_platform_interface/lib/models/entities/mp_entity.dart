part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An interface describing trivial properties of a MapsIndoors geographical entities
abstract class MPEntity<T extends DynamicObjectId> extends MapsIndoorsObject
    implements DynamicObject<T> {
  MPPoint get position;
  MPBounds? get bounds;
  bool isPoint();
}
