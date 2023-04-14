part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An implementation of [MapsindoorsPlatform] that uses method channels.
class MethodChannelMapsindoors extends MapsindoorsPlatform
    implements OnPositionUpdateListener {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final mapsIndoorsMethodChannel =
      const MethodChannel('MapsIndoorsMethodChannel');
  final listenerChannel = const MethodChannel('MapsIndoorsListenerChannel');
  final List<OnMapsIndoorsReadyListener> _readyListeners =
      List.empty(growable: true);

  MPPositionProviderInterface? _positionProvider;

  MethodChannelMapsindoors() {
    listenerChannel.setMethodCallHandler((call) => _listenerHandler(call));
  }

  Future<dynamic> _listenerHandler(MethodCall call) async {
    switch (call.method) {
      case "onMapsIndoorsReady":
        final MPError? error = MPError.fromJson(call.arguments);
        for (var listener in _readyListeners) {
          listener.onMapsIndoorsReady(error);
        }
        break;

      default:
        throw UnimplementedError();
    }
  }

  @override
  void onPositionUpdate(MPPositionResultInterface position) {
    listenerChannel.invokeMethod('MIL_onPositionUpdate', {"position":position._jsonEncode()});
  }

  @override
  Future<MPError?> load(String key) async {
    final error =
        await mapsIndoorsMethodChannel.invokeMethod('MIN_initialize', {"key":key});
    return MPError.fromJson(error);
  }
  @override
  Future<bool?> locationDisplayRuleExists(MPLocationId location) async {
    return await mapsIndoorsMethodChannel
        .invokeMethod("MIN_locationDisplayRuleExists", {"id":location.value});
  }

  @override
  Future<bool?> displayRuleNameExists(String name) async {
    return await mapsIndoorsMethodChannel
        .invokeMethod("MIN_displayRuleNameExists", {"name":name});
  }

  @override
  void addOnMapsIndoorsReadyListener(OnMapsIndoorsReadyListener listener) {
    if (_readyListeners.isEmpty) {
      listenerChannel.invokeMethod("MIL_onMapsIndoorsReadyListener", {"addListener":true});
    }
    _readyListeners.add(listener);
  }

  @override
  void removeOnMapsIndoorsReadyListener(OnMapsIndoorsReadyListener listener) {
    _readyListeners.remove(listener);
    if (_readyListeners.isEmpty) {
      listenerChannel.invokeMethod("MIL_onMapsIndoorsReadyListener", {"addListener":false});
    }
  }

  @override
  Future<bool?> checkOfflineDataAvailability() {
    return mapsIndoorsMethodChannel
        .invokeMethod("MIN_checkOfflineDataAvailability");
  }

  @override
  Future<void> destroy() {
    return mapsIndoorsMethodChannel.invokeMethod("MIN_destroy");
  }

  @override
  Future<void> disableEventLogging(bool disable) {
    return mapsIndoorsMethodChannel.invokeMethod(
        "MIN_disableEventLogging", {"disable":disable});
  }

  @override
  Future<String?> getAPIKey() async {
    return await mapsIndoorsMethodChannel.invokeMethod("MIN_getAPIKey");
  }

  @override
  Future<List<String>?> getAvailableLanguages() {
    return mapsIndoorsMethodChannel
        .invokeListMethod<String>("MIN_getAvailableLanguages");
  }

  @override
  Future<MPBuildingCollection?> getBuildings() async {
    final buildings =
        await mapsIndoorsMethodChannel.invokeMethod("MIN_getBuildings");
    return MPBuildingCollection.fromJson(buildings);
  }

  @override
  Future<MPCategoryCollection?> getCategories() async {
    final categories =
        await mapsIndoorsMethodChannel.invokeMethod("MIN_getCategories");
    return MPCategoryCollection.fromJson(categories);
  }

  @override
  Future<String?> getDefaultLanguage() {
    return mapsIndoorsMethodChannel.invokeMethod("MIN_getDefaultLanguage");
  }

  @override
  Future<String?> getLanguage() {
    return mapsIndoorsMethodChannel.invokeMethod("MIN_getLanguage");
  }

  @override
  Future<MPLocation?> getLocationById(String id) async {
    final location =
        await mapsIndoorsMethodChannel.invokeMethod("MIN_getLocationById", {"id":id});
    return MPLocation.fromJson(location);
  }

  @override
  Future<List<MPLocation>?> getLocations() async {
    final locations =
        await mapsIndoorsMethodChannel.invokeMethod("MIN_getLocations");
    return convertMIList<MPLocation>(
        jsonDecode(locations), (p0) => MPLocation.fromJson(p0));
  }

  @override
  Future<List<MPLocation>?> getLocationsByExternalIds(List<String> ids) async {
    final locations = await mapsIndoorsMethodChannel.invokeMethod(
        "MIN_getLocationsByExternalIds", {"ids":ids});
    return convertMIList<MPLocation>(
        jsonDecode(locations), (p0) => MPLocation.fromJson(p0));
  }

  @override
  Future<List<MPLocation>?> getLocationsByQuery(
      MPQuery? query, MPFilter? filter) async {
    final locations = await mapsIndoorsMethodChannel.invokeMethod(
        "MIN_getLocationsByQuery",
        {"query": query?._jsonEncode(), "filter": filter?._jsonEncode()});
    return convertMIList<MPLocation>(
        jsonDecode(locations), (p0) => MPLocation.fromJson(p0));
  }

  @override
  Future<List<MPMapStyle>?> getMapStyles() async {
    final mapStyles =
        await mapsIndoorsMethodChannel.invokeMethod("MIN_getMapStyles");
    return convertMIList<MPMapStyle>(
        jsonDecode(mapStyles), (p0) => MPMapStyle.fromJson(p0));
  }

  @override
  MPPositionProviderInterface? getPositionProvider() {
    return _positionProvider;
  }

  @override
  void setPositionProvider(MPPositionProviderInterface? provider) {
    _positionProvider = provider;
    _positionProvider?.addOnPositionUpdateListener(this);
    mapsIndoorsMethodChannel.invokeMethod("MIN_setPositionProvider",
        {"remove": provider == null, "name": provider?.name});
  }

  @override
  Future<MPSolution?> getSolution() async {
    final solution = await mapsIndoorsMethodChannel.invokeMethod("MIN_getSolution");
    return MPSolution.fromJson(solution);
  }

  @override
  Future<MPVenueCollection?> getVenues() async {
    final venues = await mapsIndoorsMethodChannel.invokeMethod("MIN_getVenues");
    return MPVenueCollection.fromJson(venues);
  }

  @override
  Future<bool?> isAPIKeyValid() {
    return mapsIndoorsMethodChannel.invokeMethod("MIN_isAPIKeyValid");
  }

  @override
  Future<bool?> isInitialized() {
    return mapsIndoorsMethodChannel.invokeMethod("MIN_isInitialized");
  }

  @override
  Future<bool?> isReady() {
    return mapsIndoorsMethodChannel.invokeMethod("MIN_isReady");
  }

  @override
  Future<bool?> setLanguage(String language) {
    return mapsIndoorsMethodChannel.invokeMethod("MIN_setLanguage", {"language":language});
  }

  @override
  Future<MPError?> synchronizeContent() async {
    final error =
        await mapsIndoorsMethodChannel.invokeMethod("MIN_synchronizeContent");
    return MPError.fromJson(error);
  }

  @override
  Future<void> applyUserRoles(List<MPUserRole> userRoles) {
    return mapsIndoorsMethodChannel.invokeMethod(
        "MIN_applyUserRoles", {"userRoles":convertMIListToJson(userRoles)});
  }

  @override
  Future<List<MPUserRole>?> getAppliedUserRoles() async {
    final userRoles =
        await mapsIndoorsMethodChannel.invokeMethod("MIN_getAppliedUserRoles");
    return convertMIList<MPUserRole>(
        jsonDecode(userRoles), (p0) => MPUserRole.fromJson(p0));
  }

  @override
  Future<MPUserRoleCollection?> getUserRoles() async {
    final userRoles =
        await mapsIndoorsMethodChannel.invokeMethod("MIN_getUserRoles");
    return MPUserRoleCollection.fromJson(userRoles);
  }

  @override
  Future<MPGeocodeResult?> reverseGeoCode(MPPoint point) async {
    final geoCode = await mapsIndoorsMethodChannel.invokeMethod(
        "MIN_reverseGeoCode", {"point": point._jsonEncode()});
    return MPGeocodeResult.fromJson(geoCode);
  }
  
  @override
  Future<MPVenue?> getDefaultVenue() async {
    final venue = await mapsIndoorsMethodChannel.invokeMethod("MIN_getDefaultVenue");
    return MPVenue.fromJson(venue);
  }
  
  @override
  MPDisplayRule createDisplayRuleWithName(String name) {
    return MPDisplayRule._(MPDisplayRuleId(name));
  }
}
