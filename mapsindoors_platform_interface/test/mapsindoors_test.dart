import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMapsindoorsPlatform
    with MockPlatformInterfaceMixin
    implements MapsindoorsPlatform {

  
  @override
  void addOnMapsIndoorsReadyListener(OnMapsIndoorsReadyListener listener) {
    // TODO: implement addOnMapsIndoorsReadyListener
  }
  
  @override
  Future<bool?> checkOfflineDataAvailability() {
    // TODO: implement checkOfflineDataAvailability
    throw UnimplementedError();
  }
  
  @override
  Future<void> destroy() {
    // TODO: implement destroy
    throw UnimplementedError();
  }
  
  @override
  Future<void> disableEventLogging(bool disable) {
    // TODO: implement disableEventLogging
    throw UnimplementedError();
  }
  
  @override
  Future<String?> getAPIKey() {
    // TODO: implement getAPIKey
    throw UnimplementedError();
  }
  
  @override
  Future<List<String>?> getAvailableLanguages() {
    // TODO: implement getAvailableLanguages
    throw UnimplementedError();
  }
  
  @override
  Future<String?> getDefaultLanguage() {
    // TODO: implement getDefaultLanguage
    throw UnimplementedError();
  }
  
  @override
  Future<String?> getLanguage() {
    // TODO: implement getLanguage
    throw UnimplementedError();
  }
  
  @override
  Future<MPLocation?> getLocationById(String id) {
    // TODO: implement getLocationById
    throw UnimplementedError();
  }
  
  @override
  Future<List<MPLocation>?> getLocations() {
    // TODO: implement getLocations
    throw UnimplementedError();
  }
  
  @override
  Future<List<MPLocation>?> getLocationsByExternalIds(List<String> ids) {
    // TODO: implement getLocationsByExternalIds
    throw UnimplementedError();
  }
  
  @override
  Future<List<MPLocation>?> getLocationsByQuery(MPQuery? query, MPFilter? filter) {
    // TODO: implement getLocationsByQuery
    throw UnimplementedError();
  }
  
  @override
  Future<List<MPMapStyle>?> getMapStyles() {
    // TODO: implement getMapStyles
    throw UnimplementedError();
  }
  
  @override
  MPPositionProviderInterface? getPositionProvider() {
    // TODO: implement getPositionProvider
    throw UnimplementedError();
  }
  
  @override
  Future<MPSolution?> getSolution() {
    // TODO: implement getSolution
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> isAPIKeyValid() {
    // TODO: implement isAPIKeyValid
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> isInitialized() {
    // TODO: implement isInitialized
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> isReady() {
    // TODO: implement isReady
    throw UnimplementedError();
  }
  
  @override
  Future<MPError?> load(String key) {
    // TODO: implement load
    throw UnimplementedError();
  }
  
  @override
  void removeOnMapsIndoorsReadyListener(OnMapsIndoorsReadyListener listener) {
    // TODO: implement removeOnMapsIndoorsReadyListener
  }
  
  @override
  Future<bool?> setLanguage(String language) {
    // TODO: implement setLanguage
    throw UnimplementedError();
  }
  
  @override
  Future<MPError?> synchronizeContent() {
    // TODO: implement synchronizeContent
    throw UnimplementedError();
  }
  
  @override
  Future<void> applyUserRoles(List<MPUserRole> userRoles) {
    // TODO: implement applyUserRoles
    throw UnimplementedError();
  }
  
  @override
  Future<List<MPUserRole>?> getAppliedUserRoles() {
    // TODO: implement getAppliedUserRoles
    throw UnimplementedError();
  }
  
  @override
  Future<MPGeocodeResult> reverseGeoCode(MPPoint point) {
    // TODO: implement reverseGeoCode
    throw UnimplementedError();
  }
  
  @override
  void setPositionProvider(MPPositionProviderInterface? provider) {
    // TODO: implement setPositionProvider
    throw UnimplementedError();
  }
  
  @override
  Future<MPBuildingCollection?> getBuildings() {
    // TODO: implement getBuildings
    throw UnimplementedError();
  }
  
  @override
  Future<MPCategoryCollection?> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }
  
  @override
  Future<MPUserRoleCollection?> getUserRoles() {
    // TODO: implement getUserRoles
    throw UnimplementedError();
  }
  
  @override
  Future<MPVenueCollection?> getVenues() {
    // TODO: implement getVenues
    throw UnimplementedError();
  }
  
  @override
  Future<MPVenue?> getDefaultVenue() {
    // TODO: implement getDefaultVenue
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> displayRuleNameExists(String name) {
    // TODO: implement displayRuleNameExists
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> locationDisplayRuleExists(MPLocationId location) {
    // TODO: implement locationDisplayRuleExists
    throw UnimplementedError();
  }
  
  @override
  MPDisplayRule createDisplayRuleWithName(String name) {
    // TODO: implement createDisplayRuleWithName
    throw UnimplementedError();
  }
  
}

void main() {
  final MapsindoorsPlatform initialPlatform = MapsindoorsPlatform.instance;

  test('$MethodChannelMapsindoors is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMapsindoors>());
  });

  test('getPlatformVersion', () async {
    MockMapsindoorsPlatform fakePlatform = MockMapsindoorsPlatform();
    MapsindoorsPlatform.instance = fakePlatform;

    //expect(await MapsIndoors.getPlatformVersion(), '42');
  });
}
