//
//  MapsIndoorsMethodChannel.swift
//  mapsindoors_ios
//
//  Created by Martin Hansen on 21/02/2023.
//

import Foundation
import Flutter
import UIKit
import MapsIndoors
import MapsIndoorsCodable
import MapsIndoorsCore
import MapsIndoorsGoogleMaps
import GoogleMaps

public class DirectionsServiceMethodChannel: NSObject {
    
    static var wayTypes: [MPHighway] = []
    static var isDeparture: Bool = true
    static var travelMode: MPTravelMode = MPTravelMode.walking
    static var date: Date? = nil
    
    enum Methods: String {
        case DSE_create
        case DSE_addAvoidWayType
        case DSE_clearWayType
        case DSE_setIsDeparture
        case DSE_getRoute
        case DSE_setTravelMode
        case DSE_setTime
        
        func call(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            let runner: (_ arguments: [String: Any]?, _ mapsIndoorsData: MapsIndoorsData, _ result: @escaping FlutterResult) -> Void

            switch self {
            case .DSE_create:               runner = create
            case .DSE_addAvoidWayType:      runner = addAvoidWayType
            case .DSE_clearWayType:         runner = clearWayType
            case .DSE_setIsDeparture:       runner = setIsDeparture
            case .DSE_getRoute:             runner = getRoute
            case .DSE_setTravelMode:        runner = setTravelMode
            case .DSE_setTime:              runner = setTime
            }
            
            runner(arguments, mapsIndoorsData, result)
        }
        
        func create(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            result(nil)
        }
        
        func addAvoidWayType(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "Initialized called without arguments", message: "DSE_addAvoidWayType", details: nil))
                return
            }
            
            guard let wayType = args["wayType"] as? String else {
                result(FlutterError(code: "Could not initialise MapsIndoors", message: "DSE_addAvoidWayType", details: nil))
                return
            }
            
            let avoidWaytype = MPHighway(typeString: wayType)
            if (avoidWaytype != MPHighway.unclassified) {
                DirectionsServiceMethodChannel.wayTypes.append(avoidWaytype)
            }
            
            result(nil)
        }
        
        func clearWayType(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            DirectionsServiceMethodChannel.wayTypes.removeAll()
            result(nil)
        }
        
        func setIsDeparture(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "Initialized called without arguments", message: "DSE_setIsDeparture", details: nil))
                return
            }
            
            guard let isDeparture = args["isDeparture"] as? Bool else {
                result(FlutterError(code: "Could not initialise MapsIndoors", message: "DSE_setIsDeparture", details: nil))
                return
            }
            
            DirectionsServiceMethodChannel.isDeparture = isDeparture
            result(nil)
        }
        
        func getRoute(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: "DSE_getRoute", details: nil))
                return
            }
            
            guard let originJson = args["origin"] else {
                result(FlutterError(code: "Could not read origin point", message: "DSE_getRoute", details: nil))
                return
            }
            
            guard let destinationJson = args["destination"] else {
                result(FlutterError(code: "Could not read destination point", message: "DSE_getRoute", details: nil))
                return
            }
            var origin: MPPoint? = nil
            var destination: MPPoint? = nil
            
            do {
                origin = try JSONDecoder().decode(MPPoint.self, from: Data(originJson.utf8))
                destination = try JSONDecoder().decode(MPPoint.self, from: Data(destinationJson.utf8))
            } catch {
                result(FlutterError(code: "Unable to parse origin or destination point", message: "DSE_getRoute", details: nil))
            }
            
            if (origin != nil && destination != nil) {
                let query = MPDirectionsQuery(originPoint: origin!, destinationPoint: destination!)
                if (!DirectionsServiceMethodChannel.wayTypes.isEmpty) {
                    query.avoidWayTypes = DirectionsServiceMethodChannel.wayTypes
                }
                
                if (DirectionsServiceMethodChannel.date != nil) {
                    if (DirectionsServiceMethodChannel.isDeparture) {
                        query.departure = DirectionsServiceMethodChannel.date
                    }else {
                        query.arrival = DirectionsServiceMethodChannel.date
                    }
                }
                
                query.travelMode = DirectionsServiceMethodChannel.travelMode
                
                Task {
                    let route = try await MPMapsIndoors.shared.directionsService.routingWith(query: query)
                    if (route != nil) {
                        let routeData = try? JSONEncoder().encode(MPRouteCodable(withRoute: route!))
                        if (routeData != nil) {
                            let routeRoute = String(data: routeData!, encoding: String.Encoding.utf8)
                            var map = Dictionary<String, String>()
                            map["route"] = routeRoute
                            map["error"] = "null"
                            result(map)
                        }else {
                            result(FlutterError(code: "Could not parse route", message: "DSE_getRoute", details: nil))
                        }
                    }else {
                        result(nil)
                    }
                }
            }
            else {
                result(FlutterError(code: "Origin or destination is nil", message: "DSE_getRoute", details: nil))
            }
        }
        
        func setTravelMode(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "Initialized called without arguments", message: "DSE_setTravelMode", details: nil))
                return
            }
            
            guard let travelMode = args["travelMode"] as? String else {
                result(FlutterError(code: "Could not initialise MapsIndoors", message: "DSE_setTravelMode", details: nil))
                return
            }
            
            var mpTravelMode: MPTravelMode? = nil
            
            switch(travelMode) {
            case "walking":     mpTravelMode = MPTravelMode.walking;
            case "bicycling":   mpTravelMode = MPTravelMode.bicycling;
            case "driving":     mpTravelMode = MPTravelMode.driving;
            case "transit":     mpTravelMode = MPTravelMode.transit;
            default:
                result(FlutterError(code: "TravelMode not found", message: "DSE_setTravelMode", details: nil))
            }
            
            DirectionsServiceMethodChannel.travelMode = mpTravelMode!
            result(nil)
        }
        
        func setTime(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "Initialized called without arguments", message: "DSE_setTime", details: nil))
                return
            }
            
            guard let time = args["time"] as? Int else {
                result(FlutterError(code: "Could not initialise MapsIndoors", message: "DSE_setTime", details: nil))
                return
            }
            
            DirectionsServiceMethodChannel.date = Date(timeIntervalSince1970: TimeInterval(time/1000))
            result(nil)
        }
    }
}
