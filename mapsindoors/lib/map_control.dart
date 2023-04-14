part of 'package:mapsindoors/mapsindoors.dart';

/// The MapControl class is responsible for all things on the map and interactions concerning the map.
class MapControl extends MapControlInterface {
  MapControl._();

  /// Create a new MapControl instance.
  ///
  /// Note that new MapControl instances will only be created when/if the MapsIndoors SDK has initialized successfully.
  ///
  /// This method will wait until this condition has been met.
  static Future<MapControl> create(MPMapConfig config) async {
    MPError? error = await MapcontrolPlatform.instance.create(config);
    if (error == null) {
      return Future.value(MapControl._());
    } else {
      return Future.error(error);
    }
  }

  /// Get the currently selected venue
  @override
  Future<MPVenue?> getCurrentVenue() {
    return MapcontrolPlatform.instance.getCurrentVenue();
  }

  /// Select a venue, optionally move the camera to the given venue
  @override
  Future<void> selectVenue(MPVenue venue, bool moveCamera) {
    return MapcontrolPlatform.instance.selectVenue(venue, moveCamera);
  }

  /// Get the currently selected building
  @override
  Future<MPBuilding?> getCurrentBuilding() {
    return MapcontrolPlatform.instance.getCurrentBuilding();
  }

  /// Select a building, optionally move the camera to the given building
  @override
  Future<void> selectBuilding(MPBuilding building, bool moveCamera) {
    return MapcontrolPlatform.instance.selectBuilding(building, moveCamera);
  }

  /// Invoke this method to restore the map to its default state (POIs shown based on their display rules, etc.)
  @override
  Future<void> clearFilter() {
    return MapcontrolPlatform.instance.clearFilter();
  }

  /// Use this method to display temporary locations, not points of interests location. Use [clearFilter()] to exit this state
  ///
  /// Returns true if any locations are available
  @override
  Future<bool> setFilter(MPFilter filter, MPFilterBehavior behavior) {
    return MapcontrolPlatform.instance.setFilter(filter, behavior);
  }

  /// Use this method to display temporary locations, not points of interests location. Use [clearFilter()] to exit this state
  @override
  Future<void> setFilterWithLocations(
      List<MPLocation?> locations, MPFilterBehavior behavior) {
    return MapcontrolPlatform.instance
        .setFilterWithLocations(locations, behavior);
  }

  /// Shows or hides the [MPFloorSelectorInterface], i.e. hiding the View from [MapControl]
  ///
  /// [MapControl] will still receive relevant events on floor updates, building change etc.
  ///
  /// The Interface will also receive the events, making it possible to show/hide in real time,
  /// without refreshing the map.
  @override
  Future<void> hideFloorSelector(bool hide) {
    return MapcontrolPlatform.instance.hideFloorSelector(hide);
  }

  // setInfoWindowAdapter

  // setClusterIconAdapter

  /// Sets padding on the map.
  @override
  Future<void> setMapPadding(int start, int top, int end, int bottom) {
    return MapcontrolPlatform.instance.setMapPadding(start, top, end, bottom);
  }

  /// Sets the map style for MapsIndoors tiles
  ///
  /// [mapstyle] is a [MPMapStyle] object, a list of available [MPMapStyle]s can be fetched via [MapsIndoors.getMapStyles]
  @override
  Future<void> setMapStyle(MPMapStyle mapstyle) {
    return MapcontrolPlatform.instance.setMapStyle(mapstyle);
  }

  /// Gets the current map style of MapsIndoors tiles
  @override
  Future<MPMapStyle?> getMapStyle() {
    return MapcontrolPlatform.instance.getMapStyle();
  }

  /// Gets the Map View bottom padding
  @override
  Future<int?> getMapViewPaddingBottom() {
    return MapcontrolPlatform.instance.getMapViewPaddingBottom();
  }

  /// Gets the Map View end padding
  @override
  Future<int?> getMapViewPaddingEnd() {
    return MapcontrolPlatform.instance.getMapViewPaddingEnd();
  }

  /// Gets the Map View start padding
  @override
  Future<int?> getMapViewPaddingStart() {
    return MapcontrolPlatform.instance.getMapViewPaddingStart();
  }

  /// Gets the Map View top padding
  @override
  Future<int?> getMapViewPaddingTop() {
    return MapcontrolPlatform.instance.getMapViewPaddingTop();
  }

  /// Enables/disables the info window on user-selected locations
  ///
  /// The info window is shown by default when the user selects a location (by tapping on it)
  @override
  Future<void> showInfoWindowOnClickedLocation(bool show) {
    return MapcontrolPlatform.instance.showInfoWindowOnClickedLocation(show);
  }

  /// Returns the visibility state of the currently used [MPFloorSelectorInterface].
  @override
  Future<bool?> isFloorSelectorHidden() {
    return MapcontrolPlatform.instance.isFloorSelectorHidden();
  }

  /// Call this to deselect a location previously selected with [selectLocation(MPLocation, MPSelectionBehavior)]
  @override
  Future<void> deSelectLocation() {
    return MapcontrolPlatform.instance.deSelectLocation();
  }

  /// Sets the current visible floor to the given floorIndex one
  ///
  /// For floor names/z-index pairs check the value returned by [MPBuilding.floors]
  @override
  Future<void> selectFloor(int floorIndex) {
    return MapcontrolPlatform.instance.selectFloor(floorIndex);
  }

  /// Focus the map on the given [MPEntity].
  ///
  /// Examples of classes of type [MPEntity] are: [MPVenue], [MPBuilding],
  /// [MPBuilding], [MPLocation].
  @override
  Future<void> goTo(MPEntity? entity) {
    return MapcontrolPlatform.instance.goTo(entity);
  }

  /// Selects a location based on a [MPLocation] object.
  ///
  /// Optionally apply a [MPSelectionBehavior]
  ///
  /// Use [deSelectLocation()] or send null instead of a [MPLocation] to un-select the location.
  @override
  Future<void> selectLocation(MPLocation? location,
      [MPSelectionBehavior? behavior]) {
    return MapcontrolPlatform.instance
        .selectLocation(location, behavior ?? MPSelectionBehavior.DEFAULT);
  }

  /// Selects a location based on a id string object.
  ///
  /// Optionally apply a [MPSelectionBehavior]
  ///
  /// Use [deSelectLocation()] or send null instead of a [MPLocation] to un-select the location.
  @override
  Future<void> selectLocationById(String id, [MPSelectionBehavior? behavior]) {
    return MapcontrolPlatform.instance
        .selectLocationById(id, behavior ?? MPSelectionBehavior.DEFAULT);
  }

  /// Returns the current [MPFloor] of the current [MPBuilding] in focus
  @override
  Future<MPFloor?> getCurrentBuildingFloor() {
    return MapcontrolPlatform.instance.getCurrentBuildingFloor();
  }

  /// Returns the current floor index or [MPFloor.defaultGroundFloorIndex] if no [MPBuilding] is in focus
  @override
  Future<int?> getCurrentFloorIndex() {
    return MapcontrolPlatform.instance.getCurrentFloorIndex();
  }

  /// Replaces the default FloorSelector with a custom one.
  @override
  Future<void> setFloorSelector(MPFloorSelectorInterface floorSelector) {
    return MapcontrolPlatform.instance.setFloorSelector(floorSelector);
  }

  /// Get the current floor selector control object.
  @override
  MPFloorSelectorInterface? getFloorSelector() {
    return MapcontrolPlatform.instance.getFloorSelector();
  }

  /// Get the zoom level that MapsIndoors is currently using for display icons etc. on the map
  @override
  Future<num?> getCurrentMapsindoorsZoom() {
    return MapcontrolPlatform.instance.getCurrentMapsIndoorsZoom();
  }

  /// Renders the positioning blue dot at the last known user position on the map
  @override
  Future<void> showUserPosition(bool show) {
    return MapcontrolPlatform.instance.showUserPosition(show);
  }

  /// Returns the current visibility state of the user location icon (blue dot)
  @override
  Future<bool?> isUserPositionShown() {
    return MapcontrolPlatform.instance.isUserPositionShown();
  }

  /// Enables live data on a specific domain and uses MapsIndoors standard graphic implementation
  ///
  /// Uses a domainType string, use [LiveDataDomainTypes] to get supported strings
  @override
  Future<void> enableLiveData(String domainType,
      [OnLiveLocationUpdateListener? listener]) {
    return MapcontrolPlatform.instance.enableLiveData(domainType, listener);
  }

  /// Disables live data for a specific domainType
  @override
  Future<void> disableLiveData(String donaminType) {
    return MapcontrolPlatform.instance.disableLiveData(donaminType);
  }

  /// Add a camera event listener, invoked when a camera event occurs (e.g. moved, idle) (see [MPCameraEvent])
  @override
  void addOnCameraEventListner(MPCameraEventListener listener) {
    MapcontrolPlatform.instance.addOnCameraEventListner(listener);
  }

  /// Remove a camera event listener
  @override
  void removeOnCameraEventListner(MPCameraEventListener listener) {
    MapcontrolPlatform.instance.removeOnCameraEventListner(listener);
  }

  /// Add a listener object to catch floor changes made by either the user or the positioning service
  @override
  void addOnFloorUpdateListener(OnFloorUpdateListener listener) {
    MapcontrolPlatform.instance.addOnFloorUpdateListener(listener);
  }

  /// Remove a floor update listener
  @override
  void removeOnFloorUpdateListener(OnFloorUpdateListener listener) {
    MapcontrolPlatform.instance.removeOnFloorUpdateListener(listener);
  }

  /// Set a location selection listener, invoked when a location is selected,
  /// either by tapping on it, or programmatically with [selectLocation]
  @override
  void setOnLocationSelectedListener(
      OnLocationSelectedListener? listener, bool? consumeEvent) {
    MapcontrolPlatform.instance
        .setOnLocationSelectedListener(listener, consumeEvent);
  }

  /// Set a listener for when the map has been tapped
  @override
  void setOnMapClickListener(OnMapClickListener? listener, bool? consumeEvent) {
    MapcontrolPlatform.instance.setOnMapClickListener(listener, consumeEvent);
  }

  /// Set a marker click event listener, invoked when a marker is clicked
  @override
  void setOnMarkerClickListener(
      OnMarkerClickListener? listener, bool? consumeEvent) {
    MapcontrolPlatform.instance
        .setOnMarkerClickListener(listener, consumeEvent);
  }

  /// Set a info window click listener, invoked when an info window is clicked
  @override
  void setOnMarkerInfoWindowClickListener(
      OnMarkerInfoWindowClickListener? listener) {
    MapcontrolPlatform.instance.setOnMarkerInfoWindowClickListener(listener);
  }

  /// Uses a camera update to animate the camera.
  /// 
  /// [duration] how long the animation should take.
  @override
  Future<void> animateCamera(MPCameraUpdate update, [int? duration]) {
    return MapcontrolPlatform.instance.animateCamera(update, duration);
  }

  /// Saves the current position of the camera into a [MPCameraPosition].
  @override
  Future<MPCameraPosition> getCurrentCameraPosition() {
    return MapcontrolPlatform.instance.currentCameraPosition();
  }

  /// Uses a camera update to move the camera instantly.
  @override
  Future<void> moveCamera(MPCameraUpdate update) {
    return MapcontrolPlatform.instance.moveCamera(update);
  }

  /// Set a current building changed event listener, which is invoked when the currently selected building changes
  @override
  void setOnCurrentBuildingChangedListener(
      OnBuildingFoundAtCameraTargetListener? listener) {
    MapcontrolPlatform.instance.setOnCurrentBuildingChangedListener(listener);
  }

  /// Set a current venue changed event listener, which is invoked when the currently selected venue changes
  @override
  void setOnCurrentVenueChangedListener(
      OnVenueFoundAtCameraTargetListener? listener) {
    MapcontrolPlatform.instance.setOnCurrentVenueChangedListener(listener);
  }
}
