//
//  MapsIndoorsData.swift
//  mapsindoors_ios
//
//  Created by Martin Hansen on 21/02/2023.

import Foundation
import UIKit
import MapsIndoors
import MapsIndoorsCore
import MapsIndoorsGoogleMaps
import GoogleMaps
import Flutter
import MapsIndoorsCodable

protocol MapsIndoorsReadyDelegate: AnyObject {
    func isReady(error: MPError)
}

protocol LiveDataDelegate: AnyObject {
    func dataReceived(liveUpdate: MPLiveUpdate)
}

public class MapsIndoorsData: NSObject {
    
    private var _googleMap: GMSMapView? = nil
    private var _mapControl: MPMapControl? = nil
    private var _mapControlMethodChannel: FlutterMethodChannel? = nil
    private var _mapsIndoorsMethodChannel: FlutterMethodChannel? = nil
    private var _directionsRendererMethodChannel: FlutterMethodChannel? = nil
    private var _positionProvider: FlutterPositionProvider? = nil
    
    var delegate: MapsIndoorsReadyDelegate?
    
    var liveDataDelegate: LiveDataDelegate?
    
    var mapControlListenerDelegate: MapControlDelegate?
    
    var googleMap: GMSMapView? {
        set { _googleMap = newValue }
        get { return _googleMap }
    }

    var mapControl: MPMapControl? {
        set { _mapControl = newValue }
        get { return _mapControl }
    }
    
    var isMapControlInitialized: Bool {
        get { return _mapControl == nil }
    }
    
    var isMapsIndoorsReady: Bool {
        get { return MPMapsIndoors.shared.ready }
    }
    
    func mapsIndoorsReady(error: MPError) {
        delegate?.isReady(error: error)
    }
    
    var mapControlMethodChannel: FlutterMethodChannel? {
        set { _mapControlMethodChannel = newValue }
        get { return _mapControlMethodChannel }
    }
    
    var directionsRendererMethodChannel: FlutterMethodChannel? {
        set { _directionsRendererMethodChannel = newValue }
        get { return _directionsRendererMethodChannel }
    }

    var mapsIndoorsMethodChannel: FlutterMethodChannel? {
        set { _mapsIndoorsMethodChannel = newValue }
        get { return _mapsIndoorsMethodChannel }
    }
    
    var positionProvider: FlutterPositionProvider? {
        set { _positionProvider = newValue }
        get { return _positionProvider }
    }
}

public class FlutterPositionProvider: MPPositionProvider {
    public var latestPosition: MapsIndoors.MPPositionResult?
    
    public var name = "default"
    public var delegate: MapsIndoors.MPPositionProviderDelegate?
        
    public func setLatestPosition(positionResult: MPPositionResult) {
        latestPosition = positionResult
        delegate?.onPositionUpdate(position: positionResult)
    }
}

public class MapControlLiveDataDelegate: LiveDataDelegate {
    var methodChannel: FlutterMethodChannel? = nil
    
    init(methodChannel: FlutterMethodChannel) {
        self.methodChannel = methodChannel
    }
    
    func dataReceived(liveUpdate: MapsIndoors.MPLiveUpdate) {
        let domain = liveUpdate.topic.domainType
        let location = MPMapsIndoors.shared.locationWith(locationId: liveUpdate.itemId)
        if (location != nil && domain != nil) {
            let locationData = try? JSONEncoder().encode(MPLocationCodable(withLocation: location!))
            if (locationData != nil) {
                let locationString = String(data: locationData!, encoding: String.Encoding.utf8)
                let map = ["location": locationString, "domainType": domain]
                methodChannel?.invokeMethod("onLiveLocationUpdate", arguments: map)
            }
        }
    }
}

public class MapControlDelegate: MPMapControlDelegate {
    var methodChannel: FlutterMethodChannel
    
    var respondToTap: Bool = false
    var consumeTap: Bool = false
    
    var respondToTapIcon: Bool = false
    var consumeTapIcon: Bool = false
    
    var respondToDidChangeFloorIndex: Bool = false
    
    var respondToDidChangeBuilding: Bool = false
    
    var respondToDidChangeVenue: Bool = false
    
    var respondToDidChangeLocation: Bool = false
    var consumeChangeLocation: Bool = false
    
    var respondToDidTapInfoWindow: Bool = false
    var consumeTapInfoWindow: Bool = false
    
    
    init(methodChannel: FlutterMethodChannel) {
        self.methodChannel = methodChannel
    }
    
    public func didTap(coordinate: MPPoint) -> Bool {
        if (respondToTap) {
            var map = [String: Any?]()
            let pointData = try? JSONEncoder().encode(coordinate)
            if (pointData != nil) {
                map["point"] = String(data: pointData!, encoding: String.Encoding.utf8)
            }
            methodChannel.invokeMethod("onMapClick", arguments: map)
            return consumeTap
        }else {
            return false
        }
    }
    
    public func didTapIcon(location: MPLocation) -> Bool {
        if (respondToTapIcon) {
            methodChannel.invokeMethod("onMarkerClick", arguments: location.locationId)
            return consumeTapIcon
        }else {
            return false
        }
    }
    
    public func didChange(floorIndex: Int) -> Bool {
        if (respondToDidChangeFloorIndex) {
            var map = [String: Any]()
            map["floor"] = floorIndex
            methodChannel.invokeMethod("onFloorUpdate", arguments: map)
        }
        return false
    }
    
    public func didChange(selectedVenue: MPVenue?) -> Bool {
        if (respondToDidChangeVenue) {
            var venueString: String? = nil
            if (selectedVenue != nil) {
                let venueData = try? JSONEncoder().encode(MPVenueCodable(withVenue: selectedVenue!))
                if (venueData != nil) {
                    venueString = String(data: venueData!, encoding: String.Encoding.utf8)
                }
            }
            methodChannel.invokeMethod("onVenueFoundAtCameraTarget", arguments: venueString)
        }
        return false
        
    }
    
    public func didChange(selectedBuilding: MPBuilding?) -> Bool {
        if (respondToDidChangeBuilding) {
            var buildingString: String? = nil
            if (selectedBuilding != nil) {
                let buildingData = try? JSONEncoder().encode(MPBuildingCodable(withBuilding: selectedBuilding!))
                if (buildingData != nil) {
                    buildingString = String(data: buildingData!, encoding: String.Encoding.utf8)
                }
            }
            methodChannel.invokeMethod("onBuildingFoundAtCameraTarget", arguments: buildingString)
        }
        return false
    }
    
    public func didChange(selectedLocation: MPLocation?) -> Bool {
        if (respondToDidChangeLocation) {
            var locationString: String? = nil
            if (selectedLocation != nil) {
                let locationData = try? JSONEncoder().encode(MPLocationCodable(withLocation: selectedLocation!))
                if (locationData != nil) {
                    locationString = String(data: locationData!, encoding: String.Encoding.utf8)
                }
            }
            methodChannel.invokeMethod("onLocationSelected", arguments: locationString)
        }
        return false
    }
    
    public func didTapInfoWindow(location: MPLocation) -> Bool {
        if (respondToDidTapInfoWindow) {
            methodChannel.invokeMethod("onInfoWindowClick", arguments: location.locationId)
            return consumeTapInfoWindow
        }else {
            return false
        }
    }
}
