import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:mapsindoors/mapsindoors.dart';
import 'package:mapsindoors_example/example_position_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SolutionSelector(),
    );
  }
}

class SolutionSelector extends StatefulWidget {
  const SolutionSelector({super.key});

  @override
  State<StatefulWidget> createState() => SolutionSelectorState();
}

class SolutionSelectorState extends State<SolutionSelector> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myController.text = "mapspeople";
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: TextField(
            decoration: const InputDecoration(hintText: "Enter solution id"),
            controller: myController,
            autofocus: true,
            autocorrect: false,
            onSubmitted: _loadSolution,
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => _loadSolution(myController.text),
        child: const Text("load"),
      ),
    );
  }

  Future<void> _loadSolution(String solutionId) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MapWidget(apiKey: solutionId.trim())));
  }
}

class MapWidget extends StatefulWidget {
  final String apiKey;

  const MapWidget({Key? key, required this.apiKey}) : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget>
    implements
        OnLocationSelectedListener,
        OnLegSelectedListener,
        OnMarkerClickListener,
        OnFloorUpdateListener,
        OnMarkerInfoWindowClickListener,
        OnBuildingFoundAtCameraTargetListener,
        OnVenueFoundAtCameraTargetListener {
  MPBuilding? currBuilding;
  final _floorSelectorWidget = MPDefaultFloorSelector();
  final _positionProvider = ExamplePositionProvider();
  late final MapControl mapControl;
  String? selectedVenueId;

  final MPPoint _userPosition = MPPoint.withCoordinates(
      longitude: 9.94855865542619, latitude: 57.05840589392954, floorIndex: 0);
  var _showRemoveRouteButton = false;
  MPDirectionsService? _directionsService;
  MPDirectionsRenderer? _directionsRenderer;
  PersistentBottomSheetController? directionsController;

  List<MPCategory>? categoryList = <MPCategory>[];
  final searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mapsIndoorsReadyListener(MapsIndoors.load(widget.apiKey));
  }

  void _mapsIndoorsReadyListener(Future<MPError?> error) async {
    if ((await error) == null) {
      MapControl.create(MPMapConfig()
              .setShowUserPosition(true)
              .setFloorSelector(_floorSelectorWidget))
          .then((mc) async {
        mapControl = mc;
        mapControl.goTo(await MapsIndoors.getDefaultVenue());
        /*mapControl.enableLiveData(LiveDataDomainTypes.availability.name);
        mapControl.enableLiveData(LiveDataDomainTypes.occupancy.name);
        _positionProvider.updatePosition(_userPosition,
            floorIndex: 0, bearing: 76.2, accuracy: 5.0);
      mapControl.setFloorSelector(_floorSelectorWidget);*/
        mapControl.setOnLocationSelectedListener(this, false);
        mapControl.setOnMarkerClickListener(this, false);
        mapControl.setOnCurrentVenueChangedListener(this);
        mapControl.setOnCurrentBuildingChangedListener(this);
        mapControl.addOnFloorUpdateListener(this);
      }).catchError((err) {
        print("Error: $err");
      });
      //MapsIndoors.setPositionProvider(_positionProvider);
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? controller;
  List<dynamic> menuItems = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
        title: const Text('MapsIndoors Test App'),
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () async {
              if (menuItems.isEmpty) {
                getCategories();
              }
              scaffoldKey.currentState?.openDrawer();
            }));
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      floatingActionButton: Visibility(
        visible: _showRemoveRouteButton,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 250, 100, 0)),
          onPressed: _removeRoute,
          child: Row(
            children: const [
              Icon(Icons.close),
              SizedBox(
                width: 5,
              ),
              Text("Clear Route")
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          Container(
              color: Colors.blueGrey,
              child: DrawerHeader(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          onPressed: openVenueDialog,
                          icon: const Icon(
                            Icons.menu_outlined,
                            color: Colors.black,
                          )),
                      Title(
                          color: Colors.black,
                          child: const Text("MapsIndoors")),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                  TextField(
                    controller: searchTextController,
                    onChanged: ((value) {
                      _search();
                    }),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: (() {
                            searchTextController.clear();
                            FocusScope.of(context).unfocus();
                            getCategories();
                          }),
                          icon: const Icon(Icons.clear)),
                      hintText: 'Search',
                    ),
                  ),
                ],
              ))),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => {doMenuItemAction(menuItems[index])},
                      title: Text(getTitle(menuItems[index])),
                    );
                  },
                  itemCount: menuItems.length))
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MapsIndoorsWidget(
                floorSelector: _floorSelectorWidget,
                floorSelectorAlignment: Alignment.centerRight),
          ],
        ),
      ),
    );
  }

  void closeBottomSheet() {
    controller?.close();
  }

  Future<void> getCategories() async {
    final temp = await MapsIndoors.getCategories();
    if (temp != null) {
      menuItems.clear();
      menuItems.addAll(temp.getAll());
      setState(() {});
    }
  }

  Future<void> _search() async {
    if (searchTextController.text.isEmpty) {
      getCategories();
      return;
    }
    var query = MPQuery.builder().setQuery(searchTextController.text).build();
    var filterBuilder = MPFilter.builder();
    if (selectedVenueId != null) {
      filterBuilder.setParents([selectedVenueId!]);
      filterBuilder.setDepth(4);
    }
    var filter = filterBuilder.build();

    final searchResults =
        await MapsIndoors.getLocationsByQuery(query: query, filter: filter);
    if (searchResults != null) {
      menuItems.clear();
      menuItems.addAll(searchResults);
      setState(() {});
    }
  }

  Future<void> _selectVenue(MPVenue venue) async {
    mapControl.selectVenue(venue, true);
    selectedVenueId = venue.id.value;
  }

  Future<void> openVenueDialog() async {
    final venues = await MapsIndoors.getVenues();
    var options = <Widget>[];
    if (venues != null) {
      for (var element in venues.getAll()) {
        options.add(SimpleDialogOption(
          onPressed: () => {_selectVenue(element), Navigator.pop(context)},
          child: Text(element.name!),
        ));
      }

      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Select Venue"),
              children: options,
            );
          });
    }
  }

  String getTitle(dynamic menuItem) {
    if (menuItem is MPCategory) {
      return menuItem.value;
    } else if (menuItem is MPLocation) {
      return menuItem.name;
    }
    return "";
  }

  void doMenuItemAction(dynamic menuItem) async {
    if (menuItem is MPCategory) {
      final query = MPQuery.builder().build();
      final filterBuilder =
          MPFilter.builder().setCategories(<String>[menuItem.key]);
      if (selectedVenueId != null) {
        filterBuilder.setParents([selectedVenueId!]);
        filterBuilder.setDepth(4);
      }
      List<MPLocation>? locs = await MapsIndoors.getLocationsByQuery(
          query: query, filter: filterBuilder.build());
      if (locs != null) {
        menuItems.clear();
        menuItems.addAll(locs);
        setState(() {});
      }
    } else if (menuItem is MPLocation) {
      mapControl.selectLocation(menuItem);
      scaffoldKey.currentState?.closeDrawer();
    }
  }

  @override
  void onLocationSelected(MPLocation? location) {
    var description = location?.description;
    var type = location?.typeName;
    var building = location?.buildingName;
    var floor = location?.floorName;
    scaffoldKey.currentState!.showBottomSheet((context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 30),
            Text(
              'Description: $description',
            ),
            const SizedBox(height: 10),
            Text(
              'type: $type',
            ),
            const SizedBox(height: 10),
            Text(
              '$building - $floor',
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => _routeStuff(location),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    maximumSize: const Size(150, 40)),
                child: Row(
                  children: const [
                    Icon(Icons.keyboard_arrow_left_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    Text("directions")
                  ],
                )),
            ElevatedButton(
                onPressed: () => _editDisplayRule(location),
                child: Row(
                  children: const [
                    Icon(Icons.colorize),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Display Rule")
                  ],
                ))
          ],
        ),
      );
    });
  }

  void _editDisplayRule(MPLocation? location) async {
    if (location == null) {
      return;
    }

    final displayRule = await MapsIndoors.getDisplayRuleByLocation(location);
    if (displayRule != null) {
      showDisplayRule(displayRule);
    }
  }

  //Insane amount of controllers here, because flutter
  var textController = TextEditingController();
  var numberController = TextEditingController();
  String chosenBooleanDisplayRule = "visible";
  String chosenStringDisplayRule = "icon";
  String chosenNumberDisplayRule = "zoomFrom";
  bool currentBooleanRuleState = true;
  PersistentBottomSheetController? persistentBottomSheetController;

  void showDisplayRule(MPDisplayRule displayRule) async {
    String? iconUrl = await displayRule.getIconUrl();
    if (iconUrl != null) {
      textController.text = iconUrl;
    }

    num? zoomFrom = await displayRule.getZoomFrom();
    if (zoomFrom != null) {
      numberController.text = zoomFrom.toString();
    }

    persistentBottomSheetController =
        scaffoldKey.currentState!.showBottomSheet((context) {
      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Title(color: Colors.black, child: const Text("String values")),
            Row(
              children: [
                DropdownButton(
                    items: const <DropdownMenuItem>[
                      DropdownMenuItem(value: "icon", child: Text("icon")),
                      DropdownMenuItem(value: "label", child: Text("label")),
                      DropdownMenuItem(
                          value: "polygonStrokeColor",
                          child: Text("polygonStrokeColor")),
                      DropdownMenuItem(
                          value: "polygonFillColor",
                          child: Text("polygonFillColor")),
                    ],
                    onChanged: (dynamic value) async {
                      if (value != null && value is String) {
                        chosenStringDisplayRule = value;
                        textController.text =
                            await getDisplayRuleValue(value, displayRule);
                        persistentBottomSheetController?.setState!(() {});
                      }
                    },
                    value: chosenStringDisplayRule),
                Expanded(
                    child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )),
              ],
            ),
            ElevatedButton(
                onPressed: () => saveDisplayRuleValue(
                    chosenStringDisplayRule, displayRule, textController.text),
                child: const Text("Save string")),
            Title(color: Colors.black, child: const Text("Boolean values")),
            Row(
              children: [
                DropdownButton(
                  items: const <DropdownMenuItem>[
                    DropdownMenuItem(value: "visible", child: Text("visible")),
                    DropdownMenuItem(
                        value: "iconVisible", child: Text("iconVisible")),
                    DropdownMenuItem(
                        value: "labelVisible", child: Text("labelVisible")),
                    DropdownMenuItem(
                        value: "polygonVisible", child: Text("polygonVisible")),
                    DropdownMenuItem(
                        value: "wallVisible", child: Text("wallVisible")),
                    DropdownMenuItem(
                        value: "extrusionVisible",
                        child: Text("extrusionVisible")),
                    DropdownMenuItem(
                        value: "2DModelVisible", child: Text("2DModelVisible")),
                  ],
                  onChanged: (dynamic value) async {
                    if (value != null && value is String) {
                      chosenBooleanDisplayRule = value;
                      currentBooleanRuleState =
                          await getBooleanDisplayRuleValue(value, displayRule);
                      persistentBottomSheetController?.setState!(() {});
                    }
                  },
                  value: chosenBooleanDisplayRule,
                ),
                Expanded(
                  child: DropdownButton(
                    items: const <DropdownMenuItem>[
                      DropdownMenuItem(value: true, child: Text("true")),
                      DropdownMenuItem(value: false, child: Text("false"))
                    ],
                    onChanged: (value) {
                      persistentBottomSheetController?.setState!(
                        () {
                          currentBooleanRuleState = value as bool;
                        },
                      );
                    },
                    value: currentBooleanRuleState,
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () => saveBooleanDisplayRuleValue(
                    chosenBooleanDisplayRule,
                    displayRule,
                    currentBooleanRuleState),
                child: const Text("Save bool")),
            Title(color: Colors.black, child: const Text("Numerical values")),
            Row(
              children: [
                DropdownButton(
                  items: const <DropdownMenuItem>[
                    DropdownMenuItem(
                        value: "zoomFrom", child: Text("zoomFrom")),
                    DropdownMenuItem(value: "zoomTo", child: Text("zoomTo")),
                    DropdownMenuItem(
                        value: "iconSize", child: Text("iconSize")),
                    DropdownMenuItem(
                        value: "labelZoomFrom", child: Text("labelZoomFrom")),
                    DropdownMenuItem(
                        value: "labelZoomTo", child: Text("labelZoomTo")),
                    DropdownMenuItem(
                        value: "labelMaxWidth", child: Text("labelMaxWidth")),
                    DropdownMenuItem(
                        value: "polygonZoomFrom",
                        child: Text("polygonZoomFrom")),
                    DropdownMenuItem(
                        value: "polygonZoomTo", child: Text("polygonZoomTo")),
                    DropdownMenuItem(
                        value: "polygonOpacity", child: Text("polygonOpacity")),
                  ],
                  onChanged: (dynamic value) async {
                    if (value != null && value is String) {
                      numberController.text =
                          (await getNumericalDisplayRuleValue(
                                  value, displayRule))
                              .toString();
                      chosenNumberDisplayRule = value;
                      persistentBottomSheetController?.setState!(() {});
                    }
                  },
                  value: chosenNumberDisplayRule,
                ),
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow((RegExp("[.0-9]")))
                  ],
                  controller: numberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )),
              ],
            ),
            ElevatedButton(
                onPressed: () => saveNumericalDisplayRuleValue(
                    chosenNumberDisplayRule,
                    displayRule,
                    double.parse(numberController.text)),
                child: const Text("Save number")),
          ],
        ),
      );
    });
  }

  void saveDisplayRuleValue(
      String value, MPDisplayRule displayRule, String setting) {
    switch (value) {
      case "icon":
        displayRule.setIcon(setting);
        break;
      case "label":
        displayRule.setLabel(setting);
        break;
      case "polygonStrokeColor":
        displayRule.setPolygonStrokeColor(setting);
        break;
      case "polygonFillColor":
        displayRule.setPolygonFillColor(setting);
        break;
    }
  }

  Future<String> getDisplayRuleValue(
      String value, MPDisplayRule displayRule) async {
    switch (value) {
      case "icon":
        String? value = await displayRule.getIconUrl();
        if (value != null) {
          return value;
        } else {
          return "null";
        }
      case "label":
        String? value = await displayRule.getLabel();
        if (value != null) {
          return value;
        } else {
          return "null";
        }
      case "polygonStrokeColor":
        String? value = await displayRule.getPolygonStrokeColor();
        if (value != null) {
          return value;
        } else {
          return "null";
        }
      case "polygonFillColor":
        String? value = await displayRule.getPolygonFillColor();
        if (value != null) {
          return value;
        } else {
          return "null";
        }
      default:
        return "choose a value";
    }
  }

  void saveBooleanDisplayRuleValue(
      String value, MPDisplayRule displayRule, bool setting) {
    switch (value) {
      case "visible":
        displayRule.setVisible(setting);
        break;
      case "iconVisible":
        displayRule.setIconVisible(setting);
        break;
      case "polygonVisible":
        displayRule.setPolygonVisible(setting);
        break;
      case "labelVisible":
        displayRule.setLabelVisible(setting);
        break;
      case "wallVisible":
        displayRule.setWallVisible(setting);
        break;
      case "extrusionVisible":
        displayRule.setExtrusionVisible(setting);
        break;
      case "2DModelVisible":
        displayRule.setModel2DVisible(setting);
        break;
    }
  }

  Future<bool> getBooleanDisplayRuleValue(
      String value, MPDisplayRule displayRule) async {
    switch (value) {
      case "visible":
        bool? visible = await displayRule.isVisible();
        if (visible != null && visible) {
          return true;
        } else {
          return false;
        }
      case "iconVisible":
        bool? visible = await displayRule.isIconVisible();
        if (visible != null && visible) {
          return true;
        } else {
          return false;
        }
      case "polygonVisible":
        bool? visible = await displayRule.isPolygonVisible();
        if (visible != null && visible) {
          return true;
        } else {
          return false;
        }
      case "labelVisible":
        bool? visible = await displayRule.isLabelVisible();
        if (visible != null && visible) {
          return true;
        } else {
          return false;
        }
      case "wallVisible":
        bool? visible = await displayRule.isWallVisible();
        if (visible != null && visible) {
          return true;
        } else {
          return false;
        }
      case "extrusionVisible":
        bool? visible = await displayRule.isExtrusionVisible();
        if (visible != null && visible) {
          return true;
        } else {
          return false;
        }
      case "2DModelVisible":
        bool? visible = await displayRule.isModel2DVisible();
        if (visible != null && visible) {
          return true;
        } else {
          return false;
        }
      default:
        return false;
    }
  }

  void saveNumericalDisplayRuleValue(
      String value, MPDisplayRule displayRule, double setting) {
    switch (value) {
      case "zoomFrom":
        displayRule.setZoomFrom(setting);
        break;
      case "zoomTo":
        displayRule.setZoomTo(setting);
        break;
    }
  }

  Future<num> getNumericalDisplayRuleValue(
      String value, MPDisplayRule displayRule) async {
    switch (value) {
      case "zoomFrom":
        var value = await displayRule.getZoomFrom();
        if (value != null) {
          return value;
        } else {
          return 0;
        }
      case "zoomTo":
        var value = await displayRule.getZoomTo();
        if (value != null) {
          return value;
        } else {
          return 0;
        }
    }
    return 0;
  }

  void _routeStuff(MPLocation? location) async {
    if (location == null) {
      return;
    }
    _directionsService = MPDirectionsService();
    _directionsRenderer = MPDirectionsRenderer();
    _directionsRenderer?.setOnLegSelectedListener(this);

    _directionsService
        ?.getRoute(origin: _userPosition, destination: location.point)
        .then((route) {
      _directionsRenderer?.setRoute(route);
      setState(() {
        _currentRoute = route;
        _showRemoveRouteButton = true;
      });
      _showRoute();
    }).catchError((error) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text(
          "No Route: $error",
        ),
      ));
    });
  }

  void _removeRoute() {
    mapControl.deSelectLocation();
    _directionsRenderer?.clear();
    directionsController?.close();
    setState(() {
      _showRemoveRouteButton = false;
    });
  }

  MPRoute? _currentRoute;
  int _currentIndex = 0;

  void _showRoute() {
    directionsController = scaffoldKey.currentState!.showBottomSheet((context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => updateDirectionsSheet(_currentIndex - 1),
              icon: const Icon(Icons.keyboard_arrow_left),
              iconSize: 50,
            ),
            Expanded(
              child: Text(
                expandRouteSteps(_currentRoute!.legs![_currentIndex].steps!),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              onPressed: () => updateDirectionsSheet(_currentIndex + 1),
              icon: const Icon(Icons.keyboard_arrow_right),
              iconSize: 50,
            ),
          ],
        ),
      );
    });
  }

  String expandRouteSteps(List<MPRouteStep> steps) {
    String sum = "${steps[0].maneuver}";
    for (final step in steps.skip(1)) {
      sum += ", ${step.maneuver}";
    }
    return sum;
  }

  @override
  void onLegSelected(int legIndex) {
    directionsController!.setState!(() => _currentIndex = legIndex);
  }

  void updateDirectionsSheet(int legIndex) {
    if (legIndex < 0) {
      return;
    }
    int tempIndex = min(legIndex, _currentRoute!.legs!.length - 1);
    _directionsRenderer?.selectLegIndex(tempIndex);
    directionsController!.setState!(() => _currentIndex = tempIndex);
  }

  @override
  void onBuildingFoundAtCameraTarget(MPBuilding? building) {
    if (building != null) {
      print("building found = " + building.name);
    } else {
      print("building found or not found");
    }
  }

  @override
  void onFloorUpdate(int floor) {
    print("floor = $floor");
  }

  @override
  void onInfoWindowClick(String locationId) {
    print("infowindow shown");
  }

  @override
  void onMarkerClick(String locationId) {
    print("marker clicked location id is = " + locationId);
  }

  @override
  void onVenueFoundAtCameraTarget(MPVenue? venue) {
    if (venue != null) {
      print("venue found = " + venue.administrativeId);
    } else {
      print("venue found or not found");
    }
  }
}
