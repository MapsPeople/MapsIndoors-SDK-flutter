part of 'package:mapsindoors/mapsindoors.dart';

/// A widget that contains the map used by MapsIndoors
class MapsIndoorsWidget extends StatelessWidget {
  final MPFloorSelector? floorSelector;
  final Alignment? floorSelectorAlignment;

  /// Build the widget, MapsIndoors currently supports the following platforms:
  /// * Android
  /// * iOS
  ///
  /// Has optional [MPFloorSelector] widget. Package includes a [MPDefaultFloorSelector].
  ///
  /// [floorSelectorAlignment] defaults to [Alignment.centerRight] if none is provided.
  const MapsIndoorsWidget(
      {Key? key, this.floorSelector, this.floorSelectorAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<map-view>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    final widget;

    if (Platform.isAndroid) {
      widget = AndroidView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isIOS) {
      widget = UiKitView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      throw UnimplementedError();
    }

    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Stack(children: [
        widget,
        Align(
          alignment: floorSelectorAlignment ?? Alignment.centerRight,
          child: floorSelector,
        )
      ]),
    );
  }
}
