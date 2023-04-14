part of 'package:mapsindoors_platform_interface/platform_library.dart';

abstract class MapsindoorsPlatform extends PlatformInterface {
  /// Constructs a MapsindoorsPlatform.
  MapsindoorsPlatform() : super(token: _token);

  static final Object _token = Object();

  static MapsindoorsPlatform _instance = MethodChannelMapsindoors();

  /// The default instance of [MapsindoorsPlatform] to use.
  ///
  /// Defaults to [MethodChannelMapsindoors].
  static MapsindoorsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MapsindoorsPlatform] when
  /// they register themselves.
  static set instance(MapsindoorsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  //region MapsIndoors
  Future<MPError?> load(String key);
  void addOnMapsIndoorsReadyListener(OnMapsIndoorsReadyListener listener);
  Future<bool?> checkOfflineDataAvailability();
  Future<void> destroy();
  Future<void> disableEventLogging(bool disable);
  Future<String?> getAPIKey();
  Future<List<String>?> getAvailableLanguages();
  Future<MPBuildingCollection?> getBuildings();
  Future<MPCategoryCollection?> getCategories();
  Future<String?> getDefaultLanguage();
  Future<String?> getLanguage();
  Future<MPLocation?> getLocationById(String id);
  Future<List<MPLocation>?> getLocations();
  Future<List<MPLocation>?> getLocationsByQuery(MPQuery? query, MPFilter? filter);
  Future<List<MPLocation>?> getLocationsByExternalIds(List<String> ids);
  Future<List<MPMapStyle>?> getMapStyles();
  MPPositionProviderInterface? getPositionProvider();
  void setPositionProvider(MPPositionProviderInterface? provider);
  Future<MPSolution?> getSolution();
  Future<MPVenue?> getDefaultVenue();
  Future<MPVenueCollection?> getVenues();
  Future<bool?> isAPIKeyValid();
  Future<bool?> isInitialized();
  Future<bool?> isReady();
  void removeOnMapsIndoorsReadyListener(OnMapsIndoorsReadyListener listener);
  Future<MPGeocodeResult?> reverseGeoCode(MPPoint point);
  Future<bool?> setLanguage(String language);
  Future<MPError?> synchronizeContent();
  Future<MPUserRoleCollection?> getUserRoles();
  Future<List<MPUserRole>?> getAppliedUserRoles();
  Future<void> applyUserRoles(List<MPUserRole> userRoles);
  //endregion

  //region Display Rules
  Future<bool?> locationDisplayRuleExists(MPLocationId location);
  Future<bool?> displayRuleNameExists(String name);
  MPDisplayRule createDisplayRuleWithName(String name);
  //endregion
  

}
