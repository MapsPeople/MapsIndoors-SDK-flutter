import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mapsindoors/mapsindoors.dart';
import 'package:mapsindoors_example/example_position_provider.dart';

import 'package:mapsindoors_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('MapsIndoors', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      MPError? load = await MapsIndoors.load("mapspeople");
      expect(load, null);

      MPDisplayRule? defaultDisplayRule =
          await MapsIndoors.getDefaultDisplayRule();
      expect(defaultDisplayRule?.dispalyRuleName, "default");

      MPDisplayRule? mainDisplayRule = await MapsIndoors.getMainDisplayRule();
      expect(mainDisplayRule?.dispalyRuleName, "main");

      MPDisplayRule? mainByName =
          await MapsIndoors.getDisplayRuleByName("main");
      expect(mainByName?.dispalyRuleName, "main");

      String? apiKey = await MapsIndoors.getAPIKey();
      expect(apiKey, "mapspeople");

      List<String>? languages = await MapsIndoors.getAvailableLanguages();
      expect(languages?.length, 3);

      MPBuildingCollection? buildings = await MapsIndoors.getBuildings();
      expect(buildings?.size, 5);

      MPVenueCollection? venues = await MapsIndoors.getVenues();
      expect(venues?.size, 5);

      MPVenue? defaultVenue = await MapsIndoors.getDefaultVenue();
      expect(defaultVenue, isNotNull);
      expect(defaultVenue?.administrativeId, "Stigsborgvej");

      MPCategoryCollection? categories = await MapsIndoors.getCategories();
      expect(categories?.size, 18);

      String? language = await MapsIndoors.getLanguage();
      expect(language, "en");

      MPSolution? solution = await MapsIndoors.getSolution();
      expect(solution?.availableLanguages.length, 3);

      MPLocation? location =
          await MapsIndoors.getLocationById("296994c98023439eac1f20d4");
      expect(location?.name, "Canteen");

      List<MPLocation>? locations = await MapsIndoors.getLocations();
      expect(locations?.isNotEmpty, true);

      List<String> externalIds = ["0.32.05"];
      List<MPLocation>? externalIdLocations =
          await MapsIndoors.getLocationsByExternalIds(externalIds);

      expect(externalIdLocations?.length, 1);
      expect(externalIdLocations?[0].name, "Canteen");

      MPQuery query = MPQuery.builder().build();
      MPFilter filter = MPFilterBuilder().setTypes(["Canteen"]).build();
      List<MPLocation>? locationsByFilter =
          await MapsIndoors.getLocationsByQuery(query: query, filter: filter);
      expect(locationsByFilter?.isNotEmpty, true);

      query = MPQuery.builder()
          .setQuery("apisjgaelgasdf asdoæfk oæskg æaskf nasdlfnasue")
          .build();
      filter = MPFilterBuilder().build();
      locationsByFilter =
          await MapsIndoors.getLocationsByQuery(query: query, filter: filter);
      expect(locationsByFilter?.isNotEmpty, false);

      List<MPMapStyle>? mapstyles = await MapsIndoors.getMapStyles();
      expect(mapstyles?.length, 1);
      expect(mapstyles?[0].displayName, "default");

      ExamplePositionProvider posProv = ExamplePositionProvider();
      MapsIndoors.setPositionProvider(posProv);
      expect(MapsIndoors.getPositionProvider()?.name, "random");

      bool? validApi = await MapsIndoors.isAPIKeyValid();
      expect(validApi, true);

      bool? isReady = await MapsIndoors.isReady();
      expect(isReady, true);

      MPUserRoleCollection? userRoles = await MapsIndoors.getUserRoles();
      expect(userRoles?.size != 0, true);

      MapsIndoors.applyUserRoles(userRoles!.getAll());

      var currAvailableUseRoles = await MapsIndoors.getAppliedUserRoles();
      expect(currAvailableUseRoles?.length, userRoles.size);

      MapsIndoors.applyUserRoles([]);

      currAvailableUseRoles = await MapsIndoors.getAppliedUserRoles();
      expect(currAvailableUseRoles?.length, 0);

      // This is temporary until iOS has implemented ReverseGeoCode feature
      if (Platform.isAndroid) {
        MPGeocodeResult? result = await MapsIndoors.reverseGeoCode(
            MPPoint.withCoordinates(
                longitude: 9.9508396, latitude: 57.0582701, floorIndex: 0));
        expect(result?.rooms.length, 1);
        expect(result?.floors[0].floorIndex, 0);
      }

      await MapsIndoors.setLanguage("da");
      expect(await MapsIndoors.getLanguage(), "da");

      /*// Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('Increment');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.text('1'), findsOneWidget);*/
    });
  });
}
