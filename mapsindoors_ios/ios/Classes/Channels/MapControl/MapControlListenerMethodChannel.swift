//
//  MapControlListenerMethodChannel.swift
//  mapsindoors_ios
//
//  Created by Martin Hansen on 21/02/2023.
//

import Foundation
import Flutter
import UIKit
import MapsIndoors
import MapsIndoorsCore
import MapsIndoorsCodable
import MapsIndoorsGoogleMaps
import GoogleMaps

public class MapControlListenerMethodChannel: NSObject {
    
   
    enum Methods: String {
        case MPL_cameraEventListener
        case MPL_floorUpdateListener
        case MPL_buildingFoundAtCameraTargetListener
        case MPL_venueFoundAtCameraTargetListener
        case MPL_locationClusterClickListener
        case MPL_locationSelectedListener
        case MPL_mapClickListener
        case MPL_markerClickListener
        case MPL_markerInfoWindowClickListener
        case MPL_markerInfoWindowCloseListener
        case MPL_willUpdateLocationsOnMap
        
        func call(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel?) {
            if (methodChannel == nil && mapsIndoorsData.mapControl == nil) {
                return
            }
            
            if (mapsIndoorsData.mapControlListenerDelegate == nil) {
                mapsIndoorsData.mapControlListenerDelegate = MapControlDelegate(methodChannel: methodChannel!)
            }
            mapsIndoorsData.mapControl?.delegate = mapsIndoorsData.mapControlListenerDelegate
            
            let runner: (_ arguments: [String: Any]?, _ mapsIndoorsData: MapsIndoorsData, _ result: @escaping FlutterResult, _ methodChannel: FlutterMethodChannel) -> Void
            
            switch self {
            case .MPL_cameraEventListener:                  runner = cameraEventListener
            case .MPL_floorUpdateListener:                  runner = floorUpdateListener
            case .MPL_buildingFoundAtCameraTargetListener:  runner = buildingFoundAtCameraTargetListener
            case .MPL_venueFoundAtCameraTargetListener:     runner = venueFoundAtCameraTargetListener
            case .MPL_locationClusterClickListener:         runner = locationClusterClickListener
            case .MPL_locationSelectedListener:             runner = locationSelectedListener
            case .MPL_mapClickListener:                     runner = mapClickListener
            case .MPL_markerClickListener:                  runner = markerClickListener
            case .MPL_markerInfoWindowClickListener:        runner = markerInfoWindowClickListener
            case .MPL_markerInfoWindowCloseListener:        runner = markerInfoWindowCloseListener
            case .MPL_willUpdateLocationsOnMap:             runner = willUpdateLocationsOnMap
            }
            
            runner(arguments, mapsIndoorsData, result, methodChannel!)
        }
        
        func cameraEventListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_cameraEventListener", details: nil))
                return
            }
            
            //TODO: Not implemented
            //result(FlutterError(code: "Not implemented on v4", message: nil, details: nil))
        }
        
        func floorUpdateListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_floorUpdateListener", details: nil))
                return
            }
            
            mapsIndoorsData.mapControlListenerDelegate?.respondToDidChangeFloorIndex = setupListener
        }
        
        func buildingFoundAtCameraTargetListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_buildingFoundAtCameraTargetListener", details: nil))
                return
            }
            
            mapsIndoorsData.mapControlListenerDelegate?.respondToDidChangeBuilding = setupListener
        }
        
        func venueFoundAtCameraTargetListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_venueFoundAtCameraTargetListener", details: nil))
                return
            }
            
            mapsIndoorsData.mapControlListenerDelegate?.respondToDidChangeVenue = setupListener
        }
        
        func locationClusterClickListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_locationClusterClickListener", details: nil))
                return
            }
            
            //TODO: Not implemented
            //result(FlutterError(code: "Not implemented on v4", message: nil, details: nil))
        }
        
        func locationSelectedListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_locationSelectedListener", details: nil))
                return
            }
            
            guard let consumeEvent = arguments?["consumeEvent"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_locationSelectedListener", details: nil))
                return
            }
            
            mapsIndoorsData.mapControlListenerDelegate?.respondToDidChangeLocation = setupListener
            mapsIndoorsData.mapControlListenerDelegate?.consumeChangeLocation = consumeEvent
        }
        
        func mapClickListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_mapClickListener", details: nil))
                return
            }
            
            guard let consumeEvent = arguments?["consumeEvent"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_mapClickListener", details: nil))
                return
            }
            
            mapsIndoorsData.mapControlListenerDelegate?.respondToTap = setupListener
            mapsIndoorsData.mapControlListenerDelegate?.consumeTap = consumeEvent
        }
        
        func markerClickListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_markerClickListener", details: nil))
                return
            }
            
            guard let consumeEvent = arguments?["consumeEvent"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_markerClickListener", details: nil))
                return
            }
            
            mapsIndoorsData.mapControlListenerDelegate?.respondToTapIcon = setupListener
            mapsIndoorsData.mapControlListenerDelegate?.consumeTapIcon = consumeEvent
        }
        
        func markerInfoWindowClickListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_markerInfoWindowClickListener", details: nil))
                return
            }
            
            guard let consumeEvent = arguments?["consumeEvent"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_markerInfoWindowClickListener", details: nil))
                return
            }
            
            mapsIndoorsData.mapControlListenerDelegate?.respondToDidTapInfoWindow = setupListener
            mapsIndoorsData.mapControlListenerDelegate?.consumeTapInfoWindow = consumeEvent
        }
        
        func markerInfoWindowCloseListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_markerInfoWindowCloseListener", details: nil))
                return
            }
            
            //TODO: Not implemented
            //result(FlutterError(code: "Not implemented on v4", message: nil, details: nil))
        }
        
        func willUpdateLocationsOnMap(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["setupListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MPL_willUpdateLocationsOnMap", details: nil))
                return
            }
            
            //TODO: Not implemented
            //result(FlutterError(code: "Not implemented on v4", message: nil, details: nil))
        }
    }
}
