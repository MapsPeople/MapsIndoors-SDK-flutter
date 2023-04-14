import 'package:mapsindoors/mapsindoors.dart';

class ExamplePositionProvider extends MPPositionProviderInterface {
  final List<OnPositionUpdateListener> _listeners = List.empty(growable: true);
  ExamplePositionResult? _latestPosition;
  ExamplePositionProvider();

  @override
  void addOnPositionUpdateListener(OnPositionUpdateListener listener) {
    _listeners.add(listener);
  }

  @override
  MPPositionResultInterface? getLatestPosition() {
    return _latestPosition;
  }

  @override
  String get name => "random";

  @override
  void removeOnPositionUpdateListener(OnPositionUpdateListener listener) {
    _listeners.remove(listener);
  }

  void updatePosition(MPPoint pos, {num? accuracy, num? bearing, int? floorIndex}) {
    _latestPosition = ExamplePositionResult(this, point: pos, accuracy: accuracy, bearing: bearing, floorIndex: floorIndex);
    for (final listener in _listeners) {
      listener.onPositionUpdate(_latestPosition!);
    }
  }

  void clearPosition() {
    _latestPosition = ExamplePositionResult(this);
    for (final listener in _listeners) {
      listener.onPositionUpdate(_latestPosition!);
    }
  }
}

class ExamplePositionResult extends MPPositionResultInterface {
  ExamplePositionResult(this.provider, {this.accuracy, this.bearing, this.floorIndex, this.point});
  
  @override
  num? accuracy;

  @override
  num? bearing;

  @override
  int? floorIndex;

  @override
  MPPoint? point;

  @override
  MPPositionProviderInterface provider;
}