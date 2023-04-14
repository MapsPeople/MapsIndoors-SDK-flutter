part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listener that is invoked during directions when a [MPRouteLeg] is selected
abstract class OnLegSelectedListener {
  /// when a new [legIndex] is selected
  void onLegSelected(int legIndex);
}
