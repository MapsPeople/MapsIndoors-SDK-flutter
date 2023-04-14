import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mapsindoors/mapsindoors.dart';

import 'package:mapsindoors_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('DisplayRule', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      MPError? load = await MapsIndoors.load("mapspeople");
      expect(load, null);

      final MPLocation? loc = (await MapsIndoors.getLocations())?.last;
      final MPDisplayRule? rule =
          await MapsIndoors.getDisplayRuleByLocation(loc!);
      //displayRuleTester(rule1);

      expect(rule, isNot(null));

      // neede to remove ?. notation
      if (rule != null) {

        /// IsVisible
        {
          bool? isVisible = await rule.isVisible();
          expect(isVisible, isNot(null));

          await rule.setVisible(!isVisible!);

          bool? newIsVisible = await rule.isVisible();
          expect(newIsVisible, isNot(isVisible));
        }

        /// IsIconVisible
        {
          bool? isVisible = await rule.isIconVisible();
          expect(isVisible, isNot(null));

          await rule.setIconVisible(!isVisible!);

          bool? newIsVisible = await rule.isIconVisible();
          expect(newIsVisible, isNot(isVisible));
        }

        /// ZoomFrom
        {
          num? zoomFrom = await rule.getZoomFrom();
          expect(zoomFrom, isNot(null));

          await rule.setZoomFrom(zoomFrom! - 1.0);

          num? newZoomFrom = await rule.getZoomFrom();
          expect(newZoomFrom, isNot(zoomFrom));
        }

        /// ZoomTo
        {
          num? zoomTo = await rule.getZoomTo();
          expect(zoomTo, isNot(null));

          await rule.setZoomTo(zoomTo! + 1.0);

          num? newZoomTo = await rule.getZoomTo();
          expect(newZoomTo, isNot(zoomTo));
        }

        /// IconUrl
        {
          String? url = await rule.getIconUrl();
          expect(url, isNot(null));

          await rule.setIcon("${url!}new");

          String? newUrl = await rule.getIconUrl();
          expect(newUrl, isNot(url));
        }

        /// IconSize
        {
          MPIconSize? size = await rule.getIconSize();
          expect(size, isNot(null));

          await rule.setIconSize(
              MPIconSize(height: size!.height + 1, width: size.width + 1));

          MPIconSize? newSize = await rule.getIconSize();
          expect(newSize, isNot(size));
        }

        /// IsLabelVisible
        {
          bool? isVisible = await rule.isLabelVisible();
          expect(isVisible, isNot(null));

          await rule.setLabelVisible(!isVisible!);

          bool? newIsVisible = await rule.isLabelVisible();
          expect(newIsVisible, isNot(isVisible));
        }

        /// Label
        {
          String? label = await rule.getLabel();
          expect(label, isNot(null));

          await rule.setLabel("${label!}new");

          String? newLabel = await rule.getLabel();
          expect(newLabel, isNot(label));
        }

        /// LabelZoomFrom
        {
          num? zoomFrom = await rule.getLabelZoomFrom();
          expect(zoomFrom, isNot(null));

          await rule.setLabelZoomFrom(zoomFrom! - 1.0);

          num? newZoomFrom = await rule.getLabelZoomFrom();
          expect(newZoomFrom, isNot(zoomFrom));
        }

        /// LabelZoomTo
        {
          num? zoomTo = await rule.getLabelZoomTo();
          expect(zoomTo, isNot(null));

          await rule.setLabelZoomTo(zoomTo! + 1.0);

          num? newZoomTo = await rule.getLabelZoomTo();
          expect(newZoomTo, isNot(zoomTo));
        }

        /// LabelMaxWidth
        {
          int? maxWidth = await rule.getLabelMaxWidth();
          expect(maxWidth, isNot(null));

          await rule.setLabelMaxWidth(maxWidth! + 1);

          int? newMaxWidth = await rule.getLabelMaxWidth();
          expect(newMaxWidth, isNot(maxWidth));
        }

        /// IsPolygonVisible
        {
          bool? isVisible = await rule.isPolygonVisible();
          expect(isVisible, isNot(null));

          await rule.setPolygonVisible(!isVisible!);

          bool? newIsVisible = await rule.isPolygonVisible();
          expect(newIsVisible, isNot(isVisible));
        }

        /// PolygonZoomFrom
        {
          num? zoomFrom = await rule.getPolygonZoomFrom();
          expect(zoomFrom, isNot(null));

          await rule.setPolygonZoomFrom(zoomFrom! - 1.0);

          num? newZoomFrom = await rule.getPolygonZoomFrom();
          expect(newZoomFrom, isNot(zoomFrom));
        }

        /// PolygonZoomTo
        {
          num? zoomTo = await rule.getPolygonZoomTo();
          expect(zoomTo, isNot(null));

          await rule.setPolygonZoomTo(zoomTo! + 1.0);

          num? newZoomTo = await rule.getPolygonZoomTo();
          expect(newZoomTo, isNot(zoomTo));
        }

        /// PolygonStrokeWidth
        {
          num? strokeWidth = await rule.getPolygonStrokeWidth();
          expect(strokeWidth, isNot(null));

          await rule.setPolygonStrokeWidth(strokeWidth! + 1.0);
          num? newStrokeWidth = await rule.getPolygonStrokeWidth();
          expect(newStrokeWidth, isNot(strokeWidth));
        }

        /// PolygonStrokeColor
        {
          String? color = await rule.getPolygonStrokeColor();
          expect(color, isNot(null));
          await rule.setPolygonStrokeColor("#3071D3");
          String? newColor = await rule.getPolygonStrokeColor();
          expect(newColor, isNot(color));
        }

        /// PolygonStrokeOpacity
        {
          num? opacity = await rule.getPolygonStrokeOpacity();
          expect(opacity, isNot(null));

          await rule.setPolygonStrokeOpacity(opacity! + 0.1);

          num? newOpacity = await rule.getPolygonStrokeOpacity();
          expect(newOpacity, isNot(opacity));
        }

        /// PolygonFillColor
        {
          String? color = await rule.getPolygonFillColor();
          expect(color, isNot(null));

          await rule.setPolygonFillColor("#3071D2");

          String? newColor = await rule.getPolygonFillColor();
          expect(newColor, isNot(color));
        }

        /// PolygonFillOpacity
        {
          num? opacity = await rule.getPolygonFillOpacity();
          expect(opacity, isNot(null));

          await rule.setPolygonFillOpacity(opacity! + 0.1);

          num? newOpacity = await rule.getPolygonFillOpacity();
          expect(newOpacity, isNot(opacity));
        }

        /// IsWallVisible
        {
          bool? isVisible = await rule.isWallVisible();
          expect(isVisible, isNot(null));

          await rule.setWallVisible(!isVisible!);

          bool? newIsVisible = await rule.isWallVisible();
          expect(newIsVisible, isNot(isVisible));
        }

        /// WallColor
        {
          String? color = await rule.getWallColor();
          expect(color, isNot(null));

          await rule.setWallColor("#3071D9");

          String? newColor = await rule.getWallColor();
          expect(newColor, isNot(color));
        }

        /// WallHeight
        {
          num? height = await rule.getWallHeight();
          expect(height, isNot(null));

          await rule.setWallHeight(height! + 0.1);

          num? newHeight = await rule.getWallHeight();
          expect(newHeight, isNot(height));
        }

        /// WallZoomFrom
        {
          num? zoomFrom = await rule.getWallZoomFrom();
          expect(zoomFrom, isNot(null));

          await rule.setWallZoomFrom(zoomFrom! - 1.0);

          num? newZoomFrom = await rule.getWallZoomFrom();
          expect(newZoomFrom, isNot(zoomFrom));
        }

        /// WallZoomTo
        {
          num? zoomTo = await rule.getWallZoomTo();
          expect(zoomTo, isNot(null));

          await rule.setWallZoomTo(zoomTo! + 1.0);

          num? newZoomTo = await rule.getWallZoomTo();
          expect(newZoomTo, isNot(zoomTo));
        }

        /// IsExtrusionVisible
        {
          bool? isVisible = await rule.isExtrusionVisible();
          expect(isVisible, isNot(null));

          await rule.setExtrusionVisible(!isVisible!);

          bool? newIsVisible = await rule.isExtrusionVisible();
          expect(newIsVisible, isNot(isVisible));
        }

        /// ExtrusionColor
        {
          String? color = await rule.getExtrusionColor();
          expect(color, isNot(null));

          await rule.setExtrusionColor("#3071D9");

          String? newColor = await rule.getExtrusionColor();
          expect(newColor, isNot(color));
        }

        /// ExtrusionHeight
        {
          num? height = await rule.getExtrusionHeight();
          expect(height, isNot(null));

          await rule.setExtrusionHeight(height! + 0.1);

          num? newHeight = await rule.getExtrusionHeight();
          expect(newHeight, isNot(height));
        }

        /// ExtrusionZoomFrom
        {
          num? zoomFrom = await rule.getExtrusionZoomFrom();
          expect(zoomFrom, isNot(null));

          await rule.setExtrusionZoomFrom(zoomFrom! - 1.0);

          num? newZoomFrom = await rule.getExtrusionZoomFrom();
          expect(newZoomFrom, isNot(zoomFrom));
        }

        /// ExtrusionZoomTo
        {
          num? zoomTo = await rule.getExtrusionZoomTo();
          expect(zoomTo, isNot(null));

          await rule.setExtrusionZoomTo(zoomTo! + 1.0);

          num? newZoomTo = await rule.getExtrusionZoomTo();
          expect(newZoomTo, isNot(zoomTo));
        }

        /// Is2DModelVisible
        {
          bool? isVisible = await rule.isModel2DVisible();
          expect(isVisible, isNot(null));

          await rule.setModel2DVisible(!isVisible!);

          bool? newIsVisible = await rule.isModel2DVisible();
          expect(newIsVisible, isNot(isVisible));
        }

        /// 2DModelZoomFrom
        {
          num? zoomFrom = await rule.getModel2DZoomFrom();
          expect(zoomFrom, isNot(null));

          await rule.setModel2DZoomFrom(zoomFrom! - 1.0);

          num? newZoomFrom = await rule.getModel2DZoomFrom();
          expect(newZoomFrom, isNot(zoomFrom));
        }

        /// 2DModelZoomTo
        {
          num? zoomTo = await rule.getModel2DZoomTo();
          expect(zoomTo, isNot(null));

          await rule.setModel2DZoomTo(zoomTo! + 1.0);

          num? newZoomTo = await rule.getModel2DZoomTo();
          expect(newZoomTo, isNot(zoomTo));
        }

        /* TODO: hold test until model2dmodel is setable in next version (4.1.0)
        /// 2DModelModel
        {
          String? name = await rule.getModel2DModel();
          expect(name, null);

          await rule.setModel2DModel("new");

          String? newName = await rule.getModel2DModel();
          expect(newName, isNot(name));
        }
        */

        /// 2DModelHeight
        {
          num? height = await rule.getModel2DHeightMeters();
          expect(height, isNot(null));

          await rule.setModel2DHeightMeters(height! + 1.0);

          num? newHeight = await rule.getModel2DHeightMeters();
          expect(newHeight, isNot(height));
        }

        /// 2DModelWidth
        {
          num? width = await rule.getModel2DWidthMeters();
          expect(width, isNot(null));

          await rule.setModel2DWidthMeters(width! + 1.0);

          num? newWidth = await rule.getModel2DWidthMeters();
          expect(newWidth, isNot(width));
        }

        /// 2DModelBearing
        {
          num? bearing = await rule.getModel2DBearing();
          expect(bearing, isNot(null));

          await rule.setModel2DBearing(bearing! + 1.0);

          num? newBearing = await rule.getModel2DBearing();
          expect(newBearing, isNot(bearing));
        }

        // reset the rule after validating again
        await rule.reset();
      }
    });
  });
}
