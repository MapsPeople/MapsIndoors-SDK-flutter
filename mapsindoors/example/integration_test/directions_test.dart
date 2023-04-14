import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mapsindoors/mapsindoors.dart';

import 'package:mapsindoors_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Directions', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final Finder fab = find.byType(ElevatedButton);
      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle(const Duration(seconds: 4));

      final app.MapWidgetState state = tester.state(find.byType(app.MapWidget));

      MapControl? mapControl = state.mapControl;

      expect(mapControl, isNot(null));

      MPDirectionsService service = MPDirectionsService();
      MPDirectionsRenderer renderer = MPDirectionsRenderer();

      await service.addAvoidWayType(MPHighway.steps.name);
      await service.addAvoidWayType("gert");
      await service.clearWayType();

      await service.setIsDeparture(true);
      await service.setIsDeparture(false);
      await service.setTime(1675764926);

      await service.setTravelMode(MPDirectionsService.travelModeTransit);
      await service.setTravelMode(MPDirectionsService.travelModeDriving);
      await service.setTravelMode(MPDirectionsService.travelModeBicycling);
      await service.setTravelMode(MPDirectionsService.travelModeWalking);

      // ensure null route does not throw an error
      await service.getRoute(origin: MPPoint(), destination: MPPoint());

      final MPPoint insideFloor10 = MPPoint.withCoordinates(longitude: 9.950697439483086, latitude: 57.05813516976602, floorIndex: 10);
      final MPPoint insideFloor0 = MPPoint.withCoordinates(longitude: 9.950444542549313, latitude: 57.05799928441941, floorIndex: 0);
      final MPPoint insideNoIndex = MPPoint.withCoordinates(longitude: 9.950444542549313, latitude: 57.05799928441941);
      final MPPoint outside = MPPoint.withCoordinates(longitude: 9.948246747758377, latitude: 57.05846751376223, floorIndex: 0);
      final MPPoint outsideNoIndex = MPPoint.withCoordinates(longitude: 9.948246747758377, latitude: 57.05846751376223);
      final MPPoint outsideOther = MPPoint.withCoordinates(longitude: 9.94501902681362, latitude: 57.05904322246081, floorIndex: 0);

      // In/In (save route for renderer test)
      MPRoute route1 = await service.getRoute(origin: insideFloor0, destination: insideFloor10);
      // In/In reverse (also save this route)
      MPRoute route2 = await service.getRoute(origin: insideFloor10, destination: insideFloor0);
      // In/In one without floorIndex
      await service.getRoute(origin: insideNoIndex, destination: insideFloor10);
      // Out/In (see if the allows this)
      MPRoute routeOutside = await service.getRoute(origin: outside, destination: insideFloor0);
      // Out/In in without floorIndex
      await service.getRoute(origin: outside, destination: insideNoIndex);
      // In/Out
      await service.getRoute(origin: insideFloor0, destination: outside);
      // Out/In no floorIndex
      await service.getRoute(origin: outsideNoIndex, destination: insideNoIndex);
      // Out/Out
      await service.getRoute(origin: outside, destination: outsideOther);
      // In/In same point
      await service.getRoute(origin: insideFloor0, destination: insideFloor0);

      // The route should work
      expect(route1, isNot(null));
      expect(route2, isNot(null));
      expect(routeOutside, isNot(null));

      final listener = OLSL();
      await renderer.setOnLegSelectedListener(listener);

      await renderer.setRoute(route1);

      expect(listener.index, 0);

      // Should already be the first leg, test if previousLeg causes an issue
      await renderer.previousLeg();

      expect(listener.index, 0);

      // Go back and forth
      await renderer.nextLeg();
      expect(listener.index, 1);
      await renderer.previousLeg();
      expect(listener.index, 0);

      await renderer.selectLegIndex(0);
      expect(listener.index, 0);

      var selectedLegFloorIndex = await renderer.getSelectedLegFloorIndex();
      expect(selectedLegFloorIndex, 0);

      await renderer.selectLegIndex(1);
      expect(listener.index, 1);

      selectedLegFloorIndex = await renderer.getSelectedLegFloorIndex();
      expect(selectedLegFloorIndex, 10);

      
      // These works because the SDK is not in debug mode
      await renderer.selectLegIndex(-1);
      await renderer.selectLegIndex(99);


      await renderer.setAnimatedPolyline(true, true, 600);

      await renderer.setAnimatedPolyline(false, true, 0);

      await renderer.setCameraAnimationDuration(0);
      await renderer.setCameraAnimationDuration(50000);
      await renderer.setCameraViewFitMode(MPCameraViewFitMode.firstStepAligned);
      await renderer.setCameraViewFitMode(MPCameraViewFitMode.northAligned);

      await renderer.setRoute(route1);
      await renderer.setRoute(route2);

      await renderer.setOnLegSelectedListener(null);
      
      await renderer.setPolyLineColors("#554433", "#667788");
      await renderer.setPolyLineColors("#FF554433", "#00667788");

      try {
        await renderer.setPolyLineColors("Gert", "Berthe");
        fail("Exception not thrown");
      } catch (e) {
        expect(e, isInstanceOf<PlatformException>());
      }


    });
  });
}

class OLSL implements OnLegSelectedListener {
  int index = 0;
  @override
  void onLegSelected(int legIndex) {
    index = legIndex;
  }

}