
A federated Flutter plugin for integrating with the native MapsIndoors SDK.

| Platform     | Android | iOS   |
| ------------ | ------- | ----- |
| **Supports** | SDK 21+ | 13.0+ |

# ReadMe

## Features

​
Use this plugin to:
​

- Show indoor mapping and navigation.
- Perform real-time wayfinding.
- See location live updates.
​
This plugin is based on the MapsIndoors V4 SDK for Android and iOS. At the moment only Google Maps is supported.

## Getting Started

​
Add MapsIndoors version `1.0.0` to your `pubspec.yaml`.
​

```yaml
mapsindoors: ^1.0.0
```

### Android

​

#### Android Gooogle Maps Setup

​
To get the underlying Google Map to function, you need to perform the following steps:
​

1. Navigate to `android/app/src/main/res/value`.
2. Create a file in this folder called `google_maps_api_key.xml`.
3. Copy and paste the below code snippet and replace `YOUR_KEY_HERE` with your Google Maps API key.

​

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="google_maps_key">YOUR_KEY_HERE</string>
</resources>
```

​

#### MapsIndoors Gradle Setup

​
The plugin Gradle project has trouble resolving the MapsIndoors dependency, so to ensure that it is resolved correctly, do the following:
​

1. Navigate to the app's project level `build.gradle`.
2. add `maven { url 'https://maven.mapsindoors.com/' }` to `allprojects`/`repositories` after `mavenCentral()`
​

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://maven.mapsindoors.com/' }
    }
}
```

​

### iOS

#### iOS Gooogle Maps Setup

​
To get the underlying Google Map to function, you need to perform the following steps:

#### Providing API key

##### Swift

1. Navigate to `iOS/Runner/AppDelegate.swift`.
2. Import GoogleMaps on the class
3. Add this code as the first line inside the application function: `GMSServices.provideAPIKey("YOUR GOOGLE MAPS API KEY HERE")`

##### Objective-C

1. Navigate to `iOS/Runner/AppDelegate.h`.
2. Import `#import "GoogleMaps/GoogleMaps.h"` on the class.
3. Add this code as the first line inside the application function: `[GMSServices provideAPIKey:@"YOUR GOOGLE MAPS API KEY HERE"];`

#### Adding MapsIndoors script specific to Google Maps, to Podfile

After this you should navigate into the iOS folder of your flutter project and add this script to the applications Podfile: [MapsIndoors podfile Post install](https://github.com/MapsIndoors/MapsIndoorsIOS/wiki/Podfile-post_install-v4)

## Usage

​
This section has examples of code for the following tasks:
​

- [Showing your Map](#showing-your-map)
- [Showing a Route](#showing-a-route)
- [Searching Locations](#searching-locations)
- [Changing the look with DisplayRules](#changing-the-look-with-displayrules)
<!-- * [Adding a Position Provider](#adding-a-position-provider) -->
​

### Showing your Map

​
This snippet shows how to set up `MapsIndoors` in a Flutter application. First, the `MapsIndoorsWidget` is added to the application's build tree.
​
Optionally we can add a `MPFloorSelector` to the map, here we use `MPDefaultFloorSelector` as it is provided with the MapsIndoors package. The selector must be added both to the build tree as well as to `MapControl` in order to function correctly.
​
Once `initState()` has been called, `MapsIndoors` begins initialization, and once that is done successfully, `MapControl` begins initialization.
​
Once `MapControl` is initialize we can invoke the `goTo` method to move the camera to the default venue.
​

```Dart
class MapWidgetState extends State<MapWidget> {
    // Lets build a floor selector widget here, we need to add this to MapControl later.
    final _floorSelectorWidget = MPDefaultFloorSelector();
    // MapControl will be initialized after MapsIndoors.
    late final MapControl _mapControl;
​
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                // Add the MapsIndoors Widget to your Widget, it will automatically fill the container it is placed in.
                child: MapsIndoorsWidget(
                    // build with the default floor selector, this is optional.
                    floorSelector: _floorSelectorWidget,
                ),
            ),
        );
    }
​
    @override
    void initState() {
        super.initState();
        // Start initializing mapsindoors, replace the string with your own api key.
        _mapsIndoorsReadyListener(MapsIndoors.load("your_mapsindoors_api_key"));
    }
​
    void _mapsIndoorsReadyListener(Future<MPError?> error) async {
        if ((await error) == null) {
        // if no errors occured during MapsIndoors load, then we can initialize MapControl
        // we use setFloorSelector to allow MapControl to fill out the floor selector widget with floor information
            MapControl.create(MPMapConfig().setFloorSelector(_floorSelectorWidget)).then((mc) async {
                _mapControl = mc;
                // After initialization, lets show some indoor maps, here we move the camera to the default venue.
                _mapControl.goTo(await MapsIndoors.getDefaultVenue());
            }).catchError((err) {
                print("Creating mapcontrol faced an issue: $err");
            });
        } else {
            print("MapsIndoors faced an error: $error");
        }
    }
}
```

​

### Showing a Route

​
This code snippet initializes the `MPDirectionsService` and `MPDirectionsRenderer` classes, and uses `_mapControl` which have been initialized elsewhere.
​
The `showRouteToLocation` function is used to query a route from the user's current position to a specified location using `directionsService.getRoute()`.
​
If successful, the route is displayed on the map using `directionsRenderer.setRoute(route)`.
​

```Dart
// We assume MapControl has already been initialized
late final _mapControl;
​
// The user is positioned somewhere in the world
var _userLocation = MPPoint.withCoordinates(longitude: -98.44, latitude: 35.16);
/// Query a route to a location from the user's position
void showRouteToLocation(MPLocation location) async {
    // initialize services
    final directionsService = MPDirectionsService();
    final directionsRenderer = MPDirectionsRenderer();
​
    // get the route from userlocation to the location
    directionsService.getRoute(origin: _userPosition, destination: location.point).then((route) {
        // When we have the route, we can show it on the map
        directionsRenderer.setRoute(route);
    }).catchError((err) => print("An error occured: $err")); // otherwise handle the error
}
```

​

### Searching Locations

​
This code snippet shows a function called `searchForParking` that takes a single argument of type `MPPoint`. The function uses `MapsIndoors` to search for locations matching the query string `"parking"` near the point specified.
​
It mathces in the locations' descriptions, names, and external IDs to the query string. Once the search is complete, it is possible to update/get information from the locations (not specified in the code snippet).
​

```Dart
/// This method searches for locations 
void searchForParking(MPPoint point) {
    final mpq = MPQueryBuilder();
    // Set the search string
    mpq.setQuery("parking");
    // Set the point where we would like to search around
    mpq.setNear(point);
    // We are searcing in the locations description, name and external id.
    mpq.setQueryProperties([MPLocationPropertyNames.description.name, MPLocationPropertyNames.name.name, MPLocationPropertyNames.externalId.name]);
    // Apply the query on MapsIndoors.
    MapsIndoors.getLocationsByQuery(query: mpq.build()).then((locations) {
        print("number of paring near the point: ${locations?.length}");
        // do something with the locations
    });
}
```

​

### Changing the look with DisplayRules

​
This code snippet shows three ways to manipulate display rules in the MapsIndoors SDK.
​
The `hideLocationsByDefault()` method hides all markers that are not explicitly visible by setting the main display rule to not visible.
​
The `showLocationsByDefault()` method ensures all markers are shown by setting the main display rule to visible.
​
The `changeTypePolygonColor(String type, String color)` method changes the fill color for all polygons belonging to a specific type. It gets the display rule for the specified type using `getDisplayRuleByName`, and sets the fill color using `setPolygonFillColor`.
​
These methods can all be used to customize the display of markers and polygons on the map.
​

```Dart
/// This method changes the main display rule to hide all markers,
/// This will cause all locations that are not explicitly visible to be hidden.
void hideLocationsByDefault() async {
    final MPDisplayRule? main = await MapsIndoors.getMainDisplayRule();
    main?.setVisible(false);
}
​
/// This method changes the main display rule to show all markers,
/// This will cause all locations that are not explicitly visible to be shown.
void showLocationsByDefault() async {
    final MPDisplayRule? main = await MapsIndoors.getMainDisplayRule();
    main?.setVisible(true);
}
​
/// This method changes the fill color for all polygons belonging to a specific [type]
/// the [color] MUST be a valid hex color string.
void changeTypePolygonColor(String type, String color) async {
    final MPDisplayRule? rule = await MapsIndoors.getDisplayRuleByName(type);
    rule?.setPolygonFillColor(color);
}
```
