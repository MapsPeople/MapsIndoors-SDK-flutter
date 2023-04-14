part of 'package:mapsindoors_platform_interface/platform_library.dart';

abstract class MapcontrolPlatform extends PlatformInterface {
  /// Constructs a MapsindoorsPlatform.
  MapcontrolPlatform() : super(token: _token);

  static final Object _token = Object();

  static MapcontrolPlatform _instance = MethodChannelMapControl();

  /// The default instance of [MapcontrolPlatform] to use.
  ///
  /// Defaults to [MethodChannelMapcontrol].
  static MapcontrolPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MapcontrolPlatform] when
  /// they register themselves.
  static set instance(MapcontrolPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<MPError?> create(MPMapConfig config);
  Future<MPVenue?> getCurrentVenue();
  Future<void> selectVenue(MPVenue venue, bool moveCamera);
  Future<MPBuilding?> getCurrentBuilding();
  Future<void> selectBuilding(MPBuilding building, bool moveCamera);
  Future<void> clearFilter();
  Future<bool> setFilter(MPFilter filter, MPFilterBehavior behavior);
  Future<void> setFilterWithLocations(
      List<MPLocation?> locations, MPFilterBehavior behavior);
  Future<void> hideFloorSelector(bool hide);
  Future<void> setMapPadding(int start, int top, int end, int bottom);
  Future<void> setMapStyle(MPMapStyle mapstyle);
  Future<MPMapStyle?> getMapStyle();
  Future<int?> getMapViewPaddingBottom();
  Future<int?> getMapViewPaddingEnd();
  Future<int?> getMapViewPaddingStart();
  Future<int?> getMapViewPaddingTop();
  Future<void> showInfoWindowOnClickedLocation(bool show);
  Future<bool?> isFloorSelectorHidden();
  Future<void> deSelectLocation();
  Future<void> selectFloor(int floorIndex);
  Future<void> goTo(MPEntity? entity);
  Future<void> selectLocation(
      MPLocation? location, MPSelectionBehavior behavior);
  Future<void> selectLocationById(String id, MPSelectionBehavior behavior);
  Future<MPFloor?> getCurrentBuildingFloor();
  Future<int?> getCurrentFloorIndex();
  Future<num?> getCurrentMapsIndoorsZoom();
  Future<void> setFloorSelector(MPFloorSelectorInterface? floorSelector);
  MPFloorSelectorInterface? getFloorSelector();
  Future<void> showUserPosition(bool show);
  Future<bool?> isUserPositionShown();
  Future<void> enableLiveData(
      String domainType, OnLiveLocationUpdateListener? listener);
  Future<void> disableLiveData(String donaminType);
  void addOnCameraEventListner(MPCameraEventListener listener);
  void removeOnCameraEventListner(MPCameraEventListener listener);
  void addOnFloorUpdateListener(OnFloorUpdateListener listener);
  void removeOnFloorUpdateListener(OnFloorUpdateListener listener);
  void setOnCurrentBuildingChangedListener(
      OnBuildingFoundAtCameraTargetListener? listener);
  void setOnCurrentVenueChangedListener(
      OnVenueFoundAtCameraTargetListener? listener);
  void setOnLocationSelectedListener(
      OnLocationSelectedListener? listener, bool? consumeEvent);
  void setOnMapClickListener(OnMapClickListener? listener, bool? consumeEvent);
  void setOnMarkerClickListener(
      OnMarkerClickListener? listener, bool? consumeEvent);
  void setOnMarkerInfoWindowClickListener(
      OnMarkerInfoWindowClickListener? listener);

  Future<void> animateCamera(MPCameraUpdate update, [int? duration]);
  Future<void> moveCamera(MPCameraUpdate update);
  Future<MPCameraPosition> currentCameraPosition();
}
