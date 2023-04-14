library mapsindoors;

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:mapsindoors_platform_interface/platform_library.dart';
export 'package:mapsindoors_platform_interface/platform_library.dart'
    show
        MPBuilding,
        MPEntity,
        MPFloor,
        MPLocation,
        MPVenue,
        LiveDataDomainTypes,
        MPCameraEvent,
        MPCameraViewFitMode,
        MPCollisionHandling,
        MPLocationPropertyNames,
        MPLocationType,
        MPSolutionDisplayRuleEnum,
        MPBounds,
        MPGeometry,
        MPMultiPolygon,
        MPPoint,
        MPPolygon,
        MPCameraEventListener,
        OnBuildingFoundAtCameraTargetListener,
        OnFloorSelectionChangedListener,
        OnFloorUpdateListener,
        OnLegSelectedListener,
        OnLiveLocationUpdateListener,
        OnLocationSelectedListener,
        OnMapClickListener,
        OnMapsIndoorsReadyListener,
        OnMarkerClickListener,
        OnMarkerInfoWindowClickListener,
        OnPositionUpdateListener,
        OnVenueFoundAtCameraTargetListener,
        MPRouteCoordinate,
        MPRouteLeg,
        MPRouteProperty,
        MPRouteStep,
        MPRoute,
        MPBuildingInfo,
        MPCategory,
        MPDataField,
        MPDisplayRule,
        MPError,
        MPFilter,
        MPFilterBuilder,
        MPFloorSelectorInterface,
        MPGeocodeResult,
        MPIconSize,
        MPFilterBehavior,
        MPFilterBehaviorBuilder,
        MPSelectionBehavior,
        MPSelectionBehaviorBuilder,
        MPMapConfig,
        MPRouteResult,
        MPMapStyle,
        MPPositionProviderInterface,
        MPPositionResultInterface,
        MPQuery,
        MPQueryBuilder,
        MPSettings3D,
        MPSolutionConfig,
        MPSolution,
        MPUserRole,
        MPHighway,
        MPCameraPosition,
        MPCameraPositionBuilder,
        MPCameraUpdate,
        MPBuildingCollection,
        MPCategoryCollection,
        MPVenueCollection,
        MPUserRoleCollection;

part 'map_control.dart';
part 'mapsindoors_widget.dart';
part 'mp_directions_service.dart';
part 'mp_directions_renderer.dart';
part 'mp_default_floor_selector.dart';
part 'mp_floor_selector.dart';

class MapsIndoors {
  MapsIndoors._();

  /// gets the platform name and build version
  static Future<String?> getPlatformVersion() =>
      UtilPlatform.instance.getPlatformVersion();

  /// Loads content from the MapsIndoors solution matching the given API [key].
  ///
  /// Use the [MPError] to determine if the SDK has loaded successfully.
  static Future<MPError?> load(String key) =>
      MapsindoorsPlatform.instance.load(key);
  /// Retrieve the default display rule (hardcoded display rule in the SDK).
  ///
  /// Requires that [load] has successfully executed.
  static Future<MPDisplayRule?> getDefaultDisplayRule() => Future.value(
      MapsindoorsPlatform.instance.createDisplayRuleWithName("default"));

  /// Retrieve the main display rule (can be configured in the CMS).
  ///
  /// Requires that [load] has successfully executed.
  static Future<MPDisplayRule?> getMainDisplayRule() => Future.value(
      MapsindoorsPlatform.instance.createDisplayRuleWithName("main"));

  /// Retrieve the display rule for the given [location]
  ///
  /// Requires that [load] has successfully executed.
  static Future<MPDisplayRule?> getDisplayRuleByLocation(
      MPLocation location) async {
    final exists = await MapsindoorsPlatform.instance
        .locationDisplayRuleExists(location.id);
    if (exists == true) {
      return MapsindoorsPlatform.instance
          .createDisplayRuleWithName(location.id.value);
    } else {
      return null;
    }
  }

  /// Retrieve the display rule with a given [name].
  ///
  /// Requires that [load] has successfully executed.
  static Future<MPDisplayRule?> getDisplayRuleByName(String name) async {
    final exists =
        await MapsindoorsPlatform.instance.displayRuleNameExists(name);
    if (exists == true) {
      return MapsindoorsPlatform.instance.createDisplayRuleWithName(name);
    } else {
      return null;
    }
  }

  /// Retrieve the corresponding display rule for the given [MPSolutionDisplayRuleEnum].
  ///
  /// Requires that [load] has successfully executed.
  static Future<MPDisplayRule?> getSolutionDisplayRule(
          MPSolutionDisplayRuleEnum solutionDisplayRule) =>
      Future.value(MapsindoorsPlatform.instance
          .createDisplayRuleWithName(solutionDisplayRule.name));

  /// Add a one time [listener] to be invoked when [MapsIndoors] is ready
  static void addOnMapsIndoorsReadyListener(
          OnMapsIndoorsReadyListener listener) =>
      MapsindoorsPlatform.instance.addOnMapsIndoorsReadyListener(listener);

  /// Remove a MapsIndoors ready listener
  static void removeOnMapsIndoorsReadyListener(
          OnMapsIndoorsReadyListener listener) =>
      MapsindoorsPlatform.instance.removeOnMapsIndoorsReadyListener(listener);

  /// Checks if there is on device data (embedded/locally stored) available. For this to return true,
  /// data has to be available for all solution data types ([MPLocation], [MPBuilding]...)
  ///
  /// Returns true if data is available, otherwise returns false
  static Future<bool?> checkOfflineDataAvailability() =>
      MapsindoorsPlatform.instance.checkOfflineDataAvailability();

  /// Clears the internal state of MapsIndoors SDK. Any loaded content is purged from memory.
  ///
  /// Invoke [load] to start the SDK anew.
  static void destroy() => MapsindoorsPlatform.instance.destroy();

  /// [disable] SDK event logging through MapsIndoors. No logs will be created or send with this disabled.
  ///
  /// By default it is enabled. But disabled in the CMS meaning logs will be created but never uploaded.
  static Future<void> disableEventLogging(bool disable) =>
      MapsindoorsPlatform.instance.disableEventLogging(disable);

  /// Retrieves the API key that was set by using [load]
  ///
  /// Returns the API key, or "" if no key has been set
  static Future<String?> getAPIKey() =>
      MapsindoorsPlatform.instance.getAPIKey();

  /// Returns a list of the current solution's available languages
  static Future<List<String>?> getAvailableLanguages() =>
      MapsindoorsPlatform.instance.getAvailableLanguages();

  /// Gets a collection of all buildings for the current API key
  static Future<MPBuildingCollection?> getBuildings() =>
      MapsindoorsPlatform.instance.getBuildings();

  /// Gets a collection of all categories for the current API key
  static Future<MPCategoryCollection?> getCategories() =>
      MapsindoorsPlatform.instance.getCategories();

  /// Returns the current solution's default language
  static Future<String?> getDefaultLanguage() =>
      MapsindoorsPlatform.instance.getDefaultLanguage();

  /// Gets the current SDK language
  static Future<String?> getLanguage() =>
      MapsindoorsPlatform.instance.getLanguage();

  /// Retrieves a [MPLocation] by its [id]
  static Future<MPLocation?> getLocationById(String id) =>
      MapsindoorsPlatform.instance.getLocationById(id);

  /// Gets all locations (a list of [MPLocation] objects) for the current API Key
  static Future<List<MPLocation>?> getLocations() =>
      MapsindoorsPlatform.instance.getLocations();

  /// Runs a query on all the available [MPLocation]s with an optional [MPQuery] and/or [MPFilter]
  static Future<List<MPLocation>?> getLocationsByQuery(
          {MPQuery? query, MPFilter? filter}) =>
      MapsindoorsPlatform.instance.getLocationsByQuery(query, filter);

  /// Retrieves a list of [MPLocation]s by external [ids]
  static Future<List<MPLocation>?> getLocationsByExternalIds(
          List<String> ids) =>
      MapsindoorsPlatform.instance.getLocationsByExternalIds(ids);

  /// Gets a list of available map styles
  static Future<List<MPMapStyle>?> getMapStyles() =>
      MapsindoorsPlatform.instance.getMapStyles();

  /// Returns the current position provider, if any is set
  static MPPositionProviderInterface? getPositionProvider() =>
      MapsindoorsPlatform.instance.getPositionProvider();

  /// Set a new position provider, or pass null to remove the current one
  ///
  /// Positioning starts as soon as the provider is set and has produced a position
  static void setPositionProvider(MPPositionProviderInterface? provider) =>
      MapsindoorsPlatform.instance.setPositionProvider(provider);

  /// Gets the [MPSolution] for the current API key
  static Future<MPSolution?> getSolution() =>
      MapsindoorsPlatform.instance.getSolution();

  /// Gets a collection of all venues for the current API key
  static Future<MPVenueCollection?> getVenues() =>
      MapsindoorsPlatform.instance.getVenues();

  /// Check if the current API key is valid
  static Future<bool?> isAPIKeyValid() =>
      MapsindoorsPlatform.instance.isAPIKeyValid();

  /// Check if [load] has been called
  static Future<bool?> isInitialized() =>
      MapsindoorsPlatform.instance.isInitialized();

  /// Check if the SDK is initialized and ready for use
  static Future<bool?> isReady() => MapsindoorsPlatform.instance.isReady();

  /// Sets the SDK's internal language.
  ///
  /// By default, the SDK language can be:
  /// <ul>
  /// <li>the solution's default language ({@link MPSolutionInfo#getDefaultLanguage()})</li>
  /// <li>the current device language, if the MapsIndoors data isn't available (ie: first app run without network access)</li>
  /// </ul>
  static Future<bool?> setLanguage(String language) =>
      MapsindoorsPlatform.instance.setLanguage(language);

  /// Main data synchronization method
  ///
  /// If not manually invoked, [MapControl.create(config, listener)] will invoke it
  static Future<MPError?> synchronizeContent() =>
      MapsindoorsPlatform.instance.synchronizeContent();

  /// Gets the User Roles for the current solution
  ///
  /// Note that role names are localized
  static Future<MPUserRoleCollection?> getUserRoles() =>
      MapsindoorsPlatform.instance.getUserRoles();

  /// Returns the list of [MPUserRole] that is currently applied
  static Future<List<MPUserRole>?> getAppliedUserRoles() =>
      MapsindoorsPlatform.instance.getAppliedUserRoles();

  /// Applies a list of [MPUserRole]s to the SDK which will get the UserRole specific locations.
  static Future<void> applyUserRoles(List<MPUserRole> userRoles) =>
      MapsindoorsPlatform.instance.applyUserRoles(userRoles);

  /// Get a [MPGeocodeResult] that contains lists of [MPLocation] (grouped by [MPLocationType]),
  /// where the [point] is inside the locations geometry. When no floor index is set, locations on all floors are queried.
  static Future<MPGeocodeResult?> reverseGeoCode(MPPoint point) =>
      MapsindoorsPlatform.instance.reverseGeoCode(point);

  /// Gets the default venue for this solution
  static Future<MPVenue?> getDefaultVenue() =>
      MapsindoorsPlatform.instance.getDefaultVenue();
}
