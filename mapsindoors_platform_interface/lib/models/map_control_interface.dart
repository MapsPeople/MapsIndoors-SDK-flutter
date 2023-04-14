part of 'package:mapsindoors_platform_interface/platform_library.dart';

abstract class MapControlInterface {
  Future<MPVenue?> getCurrentVenue();

  Future<void> selectVenue(MPVenue venue, bool moveCamera);

  Future<MPBuilding?> getCurrentBuilding();

  Future<void> selectBuilding(MPBuilding building, bool moveCamera);

  Future<void> clearFilter();

  Future<void> setFilter(MPFilter filter, MPFilterBehavior behavior);

  Future<void> setFilterWithLocations(
      List<MPLocation> locations, MPFilterBehavior behavior);

  Future<void> hideFloorSelector(bool hide);

  // setInfoWindowAdapter

  // setClusterIconAdapter

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

  Future<void> selectLocation(MPLocation? location,
      [MPSelectionBehavior? behavior]);

  Future<void> selectLocationById(String id, [MPSelectionBehavior? behavior]);

  Future<MPFloor?> getCurrentBuildingFloor();

  Future<int?> getCurrentFloorIndex();

  Future<void> setFloorSelector(MPFloorSelectorInterface floorSelector);

  MPFloorSelectorInterface? getFloorSelector();

  Future<num?> getCurrentMapsindoorsZoom();

  Future<void> showUserPosition(bool show);

  Future<bool?> isUserPositionShown();

  Future<void> enableLiveData(String domainType,
      [OnLiveLocationUpdateListener? listener]);

  Future<void> disableLiveData(String donaminType);

  void addOnCameraEventListner(MPCameraEventListener listener);

  void removeOnCameraEventListner(MPCameraEventListener listener);

  void addOnFloorUpdateListener(OnFloorUpdateListener listener);

  void removeOnFloorUpdateListener(OnFloorUpdateListener listener);

  void setOnLocationSelectedListener(
      OnLocationSelectedListener? listener, bool? consumeEvent);

  void setOnMapClickListener(OnMapClickListener? listener, bool? consumeEvent);

  void setOnMarkerClickListener(
      OnMarkerClickListener? listener, bool? consumeEvent);

  void setOnMarkerInfoWindowClickListener(
      OnMarkerInfoWindowClickListener? listener);


  void setOnCurrentBuildingChangedListener(
      OnBuildingFoundAtCameraTargetListener? listener);

  void setOnCurrentVenueChangedListener(
      OnVenueFoundAtCameraTargetListener? listener);

  Future<void> animateCamera(MPCameraUpdate update, [int? duration]);

  Future<void> moveCamera(MPCameraUpdate update);

  Future<MPCameraPosition> getCurrentCameraPosition();
}
