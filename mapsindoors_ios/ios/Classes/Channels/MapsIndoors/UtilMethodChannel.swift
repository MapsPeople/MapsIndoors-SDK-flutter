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
import MapsIndoorsCore
import MapsIndoorsGoogleMaps
import GoogleMaps

public class UtilMethodChannel: NSObject {
    enum Methods: String {
        case UTL_getPlatformVersion
        case UTL_venueHasGraph
        case UTL_pointAngleBetween
        case UTL_pointDistanceTo
        case UTL_geometryIsInside
        case UTL_geometryArea
        case UTL_polygonDistToClosestEdge
        case UTL_parseMapClientUrl
        case UTL_setCollisionHandling
        case UTL_setEnableClustering
        case UTL_setExtrusionOpacity
        case UTL_setWallOpacity
        
        func call(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            let runner: (_ arguments: [String: Any]?, _ mapsIndoorsData: MapsIndoorsData, _ result: @escaping FlutterResult) -> Void

            switch self {
            case .UTL_getPlatformVersion:            runner = getPlatformVersion
            case .UTL_venueHasGraph:                 runner = venueHasGraph
            case .UTL_pointAngleBetween:             runner = pointAngleBetween
            case .UTL_pointDistanceTo:               runner = pointDistanceTo
            case .UTL_geometryIsInside:              runner = geometryIsInside
            case .UTL_geometryArea:                  runner = geometryArea
            case .UTL_polygonDistToClosestEdge:      runner = polygonDistToClosestEdge
            case .UTL_parseMapClientUrl:             runner = parseMapClientUrl
            case .UTL_setCollisionHandling:          runner = setCollisionHandling
            case .UTL_setEnableClustering:           runner = setEnableClustering
            case .UTL_setExtrusionOpacity:           runner = setExtrusionOpacity
            case .UTL_setWallOpacity:                runner = setWallOpacity
            }
            
            runner(arguments, mapsIndoorsData, result)
        }
            
        func getPlatformVersion(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            result("iOS " + UIDevice.current.systemVersion)
        }
        
        func venueHasGraph(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task{
                guard let args = arguments else {
                    result(FlutterError(code: "venueHasGraph called without arguments", message: "UTL_venueHasGraph", details: nil))
                    return
                }
                
                guard let venueId = args["venueId"] as? String else {
                    result(FlutterError(code: "Could not read arguments", message: "UTL_venueHasGraph", details: nil))
                    return
                }
                
                let venue = await MPMapsIndoors.shared.venueWith(id: venueId)
                result(venue?.hasGraph)
            }
        }
        
        func pointAngleBetween(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "pointAngleBetween called without arguments", message: "UTL_pointAngleBetween", details: nil))
                return
            }
            
            guard let it = args["it"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_pointAngleBetween", details: nil))
                return
            }
            
            guard let other = args["other"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_pointAngleBetween", details: nil))
                return
            }
            
            let decoder = JSONDecoder()
            let fromPoint = try! decoder.decode(MPPoint.self, from: Data(it.utf8))
            let toPoint = try! decoder.decode(MPPoint.self, from: Data(other.utf8))
            
            let fromCoordinate = fromPoint.coordinate;
            let toCoordinate = toPoint.coordinate;

            let angle = MPGeometryUtils.bearingBetweenPoints(from: fromCoordinate, to: toCoordinate)
            result(angle)
        }
        
        func pointDistanceTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "pointDistanceTo called without arguments", message: "UTL_pointDistanceTo", details: nil))
                return
            }
            
            guard let it = args["it"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_pointDistanceTo", details: nil))
                return
            }
            
            guard let other = args["other"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_pointDistanceTo", details: nil))
                return
            }
            
            let decoder = JSONDecoder()
            let itObj = try! decoder.decode(MPPoint.self, from: Data(it.utf8))
            let otherObj = try! decoder.decode(MPPoint.self, from: Data(other.utf8))
            
            let distance = itObj.distanceTo(otherObj)
            result(distance)
        }
        
        func geometryIsInside(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "geometryIsInside called without arguments", message: "UTL_geometryIsInside", details: nil))
                return
            }
            
            guard let geo = args["it"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_geometryIsInside", details: nil))
                return
            }
            
            guard let point = args["point"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_geometryIsInside", details: nil))
                return
            }
            
            let decoder = JSONDecoder()
            let geoObj = try! decoder.decode(MPGeometry.self, from: Data(geo.utf8))
            let pointObj = try! decoder.decode(MPPoint.self, from: Data(point.utf8))
            
            //Determine of the point is inside the polygon
            if(geoObj is MPPolygonGeometry) {
                let corePoly = geoObj.mp_polygon
                let geoPoint = MPGeoPoint(coordinate: CLLocationCoordinate2D(latitude: pointObj.latitude, longitude: pointObj.longitude))
                
                let polyPoints = geoObj.mp_polygon.coordinates.first?.map {CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)}
                if(polyPoints == nil) {
                    result(FlutterError(code: "Not able to read the polygon data", message: "UTL_geometryIsInside", details: nil))
                    return
                }
                    
                let geoPolygon = MPGeoPolygon(points: polyPoints!)
                
                let isInside = MPGeometryUtils.pointIntersectsPolygon(point: geoPoint, polygon: geoPolygon)
                result(isInside)
            }
            else {
                result(FlutterError(code: "The given geometry needs to be a polygon", message: "UTL_geometryIsInside", details: nil))
            }
        }
        
        func geometryArea(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "parseMapClientUrl called without arguments", message: "UTL_geometryArea", details: nil))
                return
            }
            
            guard let geo = args["geometry"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_geometryArea", details: nil))
                return
            }

            let decoder = JSONDecoder()
            let geoObj = try! decoder.decode(MPGeometry.self, from: Data(geo.utf8))

            if(geoObj is MPPoint)
            {
                result(0)
                return
            }
            if(geoObj is MPPolygonGeometry)
            {
                result(geoObj.mp_polygon?.area)
                return
            }

            result(nil)
        }
        
        func polygonDistToClosestEdge(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "parseMapClientUrl called without arguments", message: "UTL_polygonDistToClosestEdge", details: nil))
                return
            }
            
            guard let pointJson = args["point"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_polygonDistToClosestEdge", details: nil))
                return
            }

            guard let geo = args["it"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_polygonDistToClosestEdge", details: nil))
                return
            }
            
            let decoder = JSONDecoder()
            let geoObj = try! decoder.decode(MPGeometry.self, from: Data(geo.utf8))
            if( !(geoObj is MPPolygonGeometry)) {
                result(FlutterError(code: "Could not read polygon data", message: "UTL_polygonDistToClosestEdge", details: nil))
            }
            
            let point = try! decoder.decode(MPPoint.self, from: Data(pointJson.utf8))
            let geoPoint = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            
            if(geoObj is MPPolygonGeometry)
            {
                
                guard let outerRing = (geoObj.mp_polygon.coordinates.first?.map {CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)}) else
                {
                    result(FlutterError(code: "Could not read polygon data", message: "UTL_polygonDistToClosestEdge", details: nil))
                    return
                }
                
                var shortestDistance = Double.greatestFiniteMagnitude
                for i in 1 ..< outerRing.count {
                    let p1 = outerRing[i-1]
                    let p2 = outerRing[i]
                    
                    let distanceToLine = MPGeometryUtils.distancePointToLine(point: geoPoint, lineStart: p1, lineEnd: p2)
                    if( distanceToLine < shortestDistance) {
                        shortestDistance = distanceToLine
                    }
                }
                
                result(shortestDistance)
                return
            }
            result(nil)
        }
        
        func parseMapClientUrl(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "parseMapClientUrl called without arguments", message: "UTL_parseMapClientUrl", details: nil))
                return
            }
            
            guard let venueId = args["venueId"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_parseMapClientUrl", details: nil))
                return
            }

            guard let locationId = args["locationId"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_parseMapClientUrl", details: nil))
                return
            }
                        
            result(MPMapsIndoors.shared.solution?.getMapClientUrlFor(venueId: venueId, locationId: locationId))
        }
        
        func setCollisionHandling(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "setCollisionHandling called without arguments", message: "UTL_setCollisionHandling", details: nil))
                return
            }
            
            guard let handling = args["handling"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_setCollisionHandling", details: nil))
                return
            }
            
            let decoder = JSONDecoder()
            let collisionHandling = try! decoder.decode(MPCollisionHandling.self, from: Data(handling.utf8))
            
            MPMapsIndoors.shared.solution?.config.collisionHandling = collisionHandling
        }
        
        func setEnableClustering(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "setEnableClustering called without arguments", message: "UTL_setEnableClustering", details: nil))
                return
            }
            
            guard let enable = args["enable"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_setEnableClustering", details: nil))
                return
            }

            MPMapsIndoors.shared.solution?.config.enableClustering = enable == "true"
        }
        
        func setExtrusionOpacity(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "setExtrusionOpacity called without arguments", message: nil, details: nil))
                return
            }
            
            guard let opacityString = args["opacity"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_setExtrusionOpacity", details: nil))
                return
            }
            
            let opacity = Int(opacityString)
            
            //Note: 3d settings is not available in the V4 SDK yet
//            MPMapsIndoors.shared.solution?.config.settings3D["ExtrusionOpacity"] = opacity
        }
        
        func setWallOpacity(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments else {
                result(FlutterError(code: "setWallOpacity called without arguments", message: "UTL_setWallOpacity", details: nil))
                return
            }
            
            guard let opacityString = args["opacity"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "UTL_setWallOpacity", details: nil))
                return
            }
            
            let opacity = Int(opacityString)
            
            //Note: 3d settings is not available in the V4 SDK yet
//            MPMapsIndoors.shared.solution?.config.settings3D["WallOpacity"] = opacity
        }
    }
}
