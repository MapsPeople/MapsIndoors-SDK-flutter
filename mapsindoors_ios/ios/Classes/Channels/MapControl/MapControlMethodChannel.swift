//
//  MapControlMethodChannel.swift
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

public class MapControlMethodChannel: NSObject {
    
    enum Methods: String {
        case MPC_create
        case MPC_selectFloor
        case MPC_clearFilter
        case MPC_deSelectLocation
        case MPC_getCurrentBuilding
        case MPC_getCurrentBuildingFloor
        case MPC_getCurrentFloorIndex
        case MPC_setFloorSelector
        case MPC_getCurrentMapsIndoorsZoom
        case MPC_getCurrentVenue
        case MPC_getMapStyle
        case MPC_getMapViewPaddingBottom
        case MPC_getMapViewPaddingEnd
        case MPC_getMapViewPaddingStart
        case MPC_getMapViewPaddingTop
        case MPC_goTo
        case MPC_hideFloorSelector
        case MPC_isFloorSelectorHidden
        case MPC_isUserPositionShown
        case MPC_selectBuilding
        case MPC_selectLocation
        case MPC_selectLocationById
        case MPC_selectVenue
        case MPC_setFilter
        case MPC_setFilterWithLocations
        case MPC_setMapPadding
        case MPC_setMapStyle
        case MPC_showInfoWindowOnClickedLocation
        case MPC_showUserPosition
        case MPC_enableLiveData
        case MPC_disableLiveData
        case MPC_moveCamera
        case MPC_animateCamera
        case MPC_getCurrentCameraPosition

        func call(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            let runner: (_ arguments: [String: Any]?, _ mapsIndoorsData: MapsIndoorsData, _ result: @escaping FlutterResult) -> Void

            switch self {
            case .MPC_create:                           runner = create
            case .MPC_selectFloor:                      runner = selectFloor
            case .MPC_clearFilter:                      runner = clearFilter
            case .MPC_deSelectLocation:                 runner = deSelectLocation
            case .MPC_getCurrentBuilding:               runner = getCurrentBuilding
            case .MPC_getCurrentBuildingFloor:          runner = getCurrentBuildingFloor
            case .MPC_getCurrentFloorIndex:             runner = getCurrentFloorIndex
            case .MPC_setFloorSelector:                 runner = setFloorSelector
            case .MPC_getCurrentMapsIndoorsZoom:        runner = getCurrentMapsIndoorsZoom
            case .MPC_getCurrentVenue:                  runner = getCurrentVenue
            case .MPC_getMapStyle:                      runner = getMapStyle
            case .MPC_getMapViewPaddingBottom:          runner = getMapViewPaddingBottom
            case .MPC_getMapViewPaddingEnd:             runner = getMapViewPaddingEnd
            case .MPC_getMapViewPaddingStart:           runner = getMapViewPaddingStart
            case .MPC_getMapViewPaddingTop:             runner = getMapViewPaddingTop
            case .MPC_goTo:                             runner = goTo
            case .MPC_hideFloorSelector:                runner = hideFloorSelector
            case .MPC_isFloorSelectorHidden:            runner = isFloorSelectorHidden
            case .MPC_isUserPositionShown:              runner = isUserPositionShown
            case .MPC_selectBuilding:                   runner = selectBuilding
            case .MPC_selectLocation:                   runner = selectLocation
            case .MPC_selectLocationById:               runner = selectLocationById
            case .MPC_selectVenue:                      runner = selectVenue
            case .MPC_setFilter:                        runner = setFilter
            case .MPC_setFilterWithLocations:           runner = setFilterWithLocations
            case .MPC_setMapPadding:                    runner = setMapPadding
            case .MPC_setMapStyle:                      runner = setMapStyle
            case .MPC_showInfoWindowOnClickedLocation:  runner = showInfoWindowOnClickedLocation
            case .MPC_showUserPosition:                 runner = showUserPosition
            case .MPC_enableLiveData:                   runner = enableLiveData
            case .MPC_disableLiveData:                  runner = disableLiveData
            case .MPC_moveCamera:                       runner = moveCamera
            case .MPC_animateCamera:                    runner = moveCamera
            case .MPC_getCurrentCameraPosition:         runner = getCurrentCameraPosition
            }
            
            runner(arguments, mapsIndoorsData, result)
        }
        
        func create(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            if (mapsIndoorsData.googleMap != nil) {
                let config = MPMapConfig.init(gmsMapView: mapsIndoorsData.googleMap!, googleApiKey: "")
                let mapControl = MPMapsIndoors.createMapControl(mapConfig: config)
                if (mapControl != nil) {
                    mapsIndoorsData.mapControl = mapControl;
                    Task {
                        //Momentary code just to get the map to a place where we show data on the map
                        mapControl?.goTo(entity: await MPMapsIndoors.shared.venues()[0])
                        result(nil)
                    }
                } else {
                    result(FlutterError(code: "Not able to create MapControl", message: nil, details: nil))
                }
            }else {
                result(FlutterError(code: "GoogleMap has not been initialised", message: nil, details: nil))
            }
        }
        
        func selectFloor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let floorIndex = arguments?["floorIndex"] as? Int else {
                result(FlutterError(code: "Could not read floorIndex", message: nil, details: nil))
                return
            }
            
            mapsIndoorsData.mapControl?.select(floorIndex: floorIndex)
            result(nil)
        }
            

        func clearFilter(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            mapsIndoorsData.mapControl?.clearFilter()
            result(nil)
        }
        
        func deSelectLocation(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            mapsIndoorsData.mapControl?.select(location: nil, behavior: MPSelectionBehavior())
            result(nil)
        }
        
        func getCurrentBuilding(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let currentBuilding = mapsIndoorsData.mapControl?.currentBuilding else {
                result(nil)
                return
            }
            
            do {
                let jsonData = try JSONEncoder().encode(MPBuildingCodable(withBuilding: currentBuilding))
                let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
                result(resultJson)
            } catch {
                result(FlutterError(code: "Could not encode building", message: nil, details: nil))
            }
        }
        
        func getCurrentBuildingFloor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let currentFloorIndex = mapsIndoorsData.mapControl?.currentFloorIndex else {
                result(nil)
                return
            }

            guard let currentFloor = mapsIndoorsData.mapControl?.currentBuilding?.floors?[String(currentFloorIndex)] else {
                result(FlutterError(code: "Could not find currentFloor", message: nil, details: nil))
                return
            }

            let floorCodable = MPFloorCodable(withFloor: currentFloor)

            do {
                let jsonData = try JSONEncoder().encode(floorCodable)
                let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
                result(resultJson)
            } catch {
                result(FlutterError(code: "Could not encode floor", message: nil, details: nil))
            }
        }
        
        func getCurrentFloorIndex(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let currentFloorIndex = mapsIndoorsData.mapControl?.currentFloorIndex else {
                result(FlutterError(code: "Could not find currentFloor", message: nil, details: nil))
                return
            }
            result(currentFloorIndex)
        }
        
        func setFloorSelector(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            
            guard let isAutoFloorChangeEnabled = arguments?["isAutoFloorChangeEnabled"] as? Bool else {
                result(FlutterError(code: "Could not read isAutoFloorChangeEnabled", message: nil, details: nil))
                return
            }

            let currentFloorSelector = mapsIndoorsData.mapControl?.floorSelector

//            mapsIndoorsData.mapControl?.floorSelector?.onHide()
            
            //TODO: What to do here??
            //Note: "AutoFloorChangeEnabled" is always enabled on IOS
            
//            floorSelectorInterface.autoFloorChange = autoFloorChangeEnabled
//            mMapControl?.floorSelector = floorSelectorInterface
//            mMapControl?.hideFloorSelector(false)

            //result(FlutterError(code: "Not implemented", message: nil, details: nil))
            result(nil)
        }
        
        func getCurrentMapsIndoorsZoom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let currentZoom = mapsIndoorsData.mapControl?.cameraPosition.zoom else {
                result(FlutterError(code: "Could not find currentZoom", message: nil, details: nil))
                return
            }
            result(currentZoom)
        }
        
        func getCurrentVenue(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let currentVenue = mapsIndoorsData.mapControl?.currentVenue else {
                result(FlutterError(code: "Could not find currentVenue", message: nil, details: nil))
                return
            }
            do {
                let jsonData = try JSONEncoder().encode(MPVenueCodable(withVenue: currentVenue))
                let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
                result(resultJson)
            } catch {
                result(FlutterError(code: "Could not encode currentVenue", message: nil, details: nil))
            }
        }
        
        func getMapStyle(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            var mapStyle = mapsIndoorsData.mapControl?.mapStyle
            //If the mapstyle is not set, use the default style for the current venue instead
            if(mapStyle == nil) {
                guard let currentVenue = mapsIndoorsData.mapControl?.currentVenue else {
                    result(nil)
                    return
                }
                mapStyle = currentVenue.defaultStyle
                if(mapStyle == nil) {
                    result(nil)
                    return
                }
            }
            
            do {
                let jsonData = try JSONEncoder().encode(MPMapStyleCodable(withMapStyle: mapStyle!))
                let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
                result(resultJson)
            } catch {
                result(FlutterError(code: "Could not encode mapStyle", message: nil, details: nil))
            }
        }
        
        func getMapViewPaddingBottom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            let bottom = NSNumber(value: Float(mapsIndoorsData.googleMap?.padding.bottom ?? 0.0))
            result(Int.init(truncating: bottom))
        }
                                 
        
        func getMapViewPaddingEnd(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            let end = NSNumber(value: Float(mapsIndoorsData.googleMap?.padding.right ?? 0.0))
            result(Int.init(truncating: end))
        }
        
        func getMapViewPaddingStart(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            let start = NSNumber(value: Float(mapsIndoorsData.googleMap?.padding.left ?? 0.0))
            result(Int.init(truncating: start))
        }
        
        func getMapViewPaddingTop(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            let top = NSNumber(value: Float(mapsIndoorsData.googleMap?.padding.top ?? 0.0))
            result(Int.init(truncating: top))
        }
        
        func goTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: nil, details: nil))
                return
            }
            
            guard let entityJson = args["entity"] else {
                result(nil)
                return
            }

            guard let type = args["type"] else {
                result(FlutterError(code: "Could not read type", message: nil, details: nil))
                return
            }
            
            var entity: MPEntity
            
            switch type {
            case "MPLocation":
                guard let location = try? JSONDecoder().decode(MPLocationCodable.self, from: entityJson.data(using: .utf8)!) else {
                    result(FlutterError(code: "Could not parse entity as a location", message: nil, details: nil))
                    return
                }
                entity = location
            case "MPFloor":
                //TODO: MPFloorCodable does not inherit MPEntity yet. Once it does this should be changed to MPFloorCodable
                guard let floor = try? JSONDecoder().decode(MPEntityCodable.self, from: entityJson.data(using: .utf8)!) else {
                    result(FlutterError(code: "Could not parse entity as a floor", message: nil, details: nil))
                    return
                }
                entity = floor
                return

            case "MPBuilding":
                guard let building = try? JSONDecoder().decode(MPBuildingCodable.self, from: entityJson.data(using: .utf8)!) else {
                    result(FlutterError(code: "Could not parse entity as a building", message: nil, details: nil))
                    return
                }
                entity = building

            case "MPVenue":
                guard let venue = try? JSONDecoder().decode(MPVenueCodable.self, from: entityJson.data(using: .utf8)!) else {
                    result(FlutterError(code: "Could not parse venue", message: nil, details: nil))
                    return
                }
                entity = venue

            default:
                result(FlutterError(code: "Unknown type", message: nil, details: nil))
                return
            }
            
            mapsIndoorsData.mapControl?.goTo(entity: MPEntityCodable(withEntity: entity))
            result(nil)
        }
        
        func hideFloorSelector(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let hide = arguments?["hide"] as? Bool else {
                result(nil)
                return
            }
            
            mapsIndoorsData.mapControl?.hideFloorSelector = hide
            result(nil)
        }
        
        func isFloorSelectorHidden(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            if (mapsIndoorsData.mapControl != nil) {
                result(mapsIndoorsData.mapControl!.hideFloorSelector)
            }else {
                result(FlutterError(code: "Not implemented", message: nil, details: nil))
            }
        }
        
        func isUserPositionShown(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            result(mapsIndoorsData.mapControl?.showUserPosition)
        }
        
        func selectBuilding(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                
                guard let buildingJson = arguments?["building"] as? String else {
                    result(FlutterError(code: "Could not read building", message: nil, details: nil))
                    return
                }
                
                guard let moveCamera = arguments?["moveCamera"] as? Bool else {
                    result(FlutterError(code: "Could not read moveCamera", message: nil, details: nil))
                    return
                }
                
                var buildingId: String?
                do {
                    if let json = try JSONSerialization.jsonObject(with: Data(buildingJson.utf8), options: []) as? [String: Any] {
                        buildingId = json["id"] as! String?
                    }
                } catch {
                    result(FlutterError(code: "Could not read building id", message: nil, details: nil))
                    return
                }
                
                //Create a selectionBehavior with the moveCamera set as desired
                let selectionBehavior = MPSelectionBehavior()
                selectionBehavior.moveCamera = moveCamera
                
                //Find the building if possible
                guard let building = await MPMapsIndoors.shared.buildingWith(id: buildingId!) else {
                    result(FlutterError(code: "Could not find a building with the given buildingId", message: nil, details: nil))
                    return
                }
                
                mapsIndoorsData.mapControl?.select(building: building, behavior: selectionBehavior)
                result(nil)
            }
        }
        
        func selectLocation(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            
            guard let LocationId = arguments?["location"] as? String else {
                result(nil)
                return
            }
            
            guard let behaviorJson = arguments?["behavior"] as? String else {
                result(FlutterError(code: "Could not read behavior", message: nil, details: nil))
                return
            }
            
            guard let selectionBehavior = try? JSONDecoder().decode(MPSelectionBehavior.self, from: behaviorJson.data(using: .utf8)!) else {
                result(FlutterError(code: "Could not parse behavior", message: nil, details: nil))
                return
            }
            
            //Find the location if possible
            guard let location = MPMapsIndoors.shared.locationWith(locationId: LocationId) else {
                result(FlutterError(code: "Could not find a location with the given locationId", message: nil, details: nil))
                return
            }
            
            mapsIndoorsData.mapControl?.select(location: location, behavior: selectionBehavior)
            result(nil)
        }
        
        func selectLocationById(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: nil, details: nil))
                return
            }
            
            guard let locationId = args["id"] else {
                result(FlutterError(code: "Could not read locationId", message: nil, details: nil))
                return
            }
            
            guard let behaviorJson = args["behavior"] else {
                result(FlutterError(code: "Could not read behavior", message: nil, details: nil))
                return
            }
            
            guard let selectionBehavior = try? JSONDecoder().decode(MPSelectionBehavior.self, from: behaviorJson.data(using: .utf8)!) else {
                result(FlutterError(code: "Could not parse behavior", message: nil, details: nil))
                return
            }
            
            let location = MPMapsIndoors.shared.locationWith(locationId: locationId)
            if (location == nil) {
                result(FlutterError(code: "Could not find a location with the given locationId", message: nil, details: nil))
            }
            
            mapsIndoorsData.mapControl?.select(location: location, behavior: selectionBehavior)
            result(nil)        }
        
        func selectVenue(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                
                guard let venueJson = arguments?["venue"] as? String else {
                    result(FlutterError(code: "Could not read venue", message: nil, details: nil))
                    return
                }
                
                guard let moveCamera = arguments?["moveCamera"] as? Bool else {
                    result(FlutterError(code: "Could not read moveCamera", message: nil, details: nil))
                    return
                }
                
                var venueId: String?
                do {
                    if let json = try JSONSerialization.jsonObject(with: Data(venueJson.utf8), options: []) as? [String: Any] {
                        venueId = json["id"] as! String?
                    }
                } catch {
                    result(FlutterError(code: "Could not read venue id", message: nil, details: nil))
                    return
                }
                                
                //Create a selectionBehavior
                let selectionBehavior = MPSelectionBehavior()
                selectionBehavior.moveCamera = moveCamera
                                
                //Find the venue if possible
                guard let venue = await MPMapsIndoors.shared.venueWith(id: venueId!) else {
                    result(FlutterError(code: "Could not find a venue with the given venueId", message: nil, details: nil))
                    return
                }
                
                mapsIndoorsData.mapControl?.select(venue: venue, behavior: selectionBehavior)
                result(nil)
            }
        }
        
        func setFilter(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: nil, details: nil))
                return
            }
            
            guard var filterJson = args["filter"] else {
                result(FlutterError(code: "Could not read filter", message: nil, details: nil))
                return
            }
            
//            filterJson = "{\"take\":3,\"skip\":20,\"depth\":2,\"floorIndex\":10,\"categories\":[\"one\",\"two\"],\"locations\":[\"location\"],\"types\":null,\"parents\":[\"venue\"],\"mapExtend\":{\"northeast\":{\"coordinates\":[56.55467,91.2345234],\"type\":\"Point\"},\"southwest\":{\"coordinates\":[-45.213342634,-20.4234],\"type\":\"Point\"}},\"geometry\":{\"northeast\":{\"coordinates\":[89.0,90.0],\"type\":\"Point\"},\"southwest\":{\"coordinates\":[1.0,2.0],\"type\":\"Point\"}},\"ignoreLocationSearchableStatus\":false,\"ignoreLocationActiveStatus\":true}"
            
            guard let behaviorJson = args["behavior"] else {
                result(FlutterError(code: "Could not read behavior", message: nil, details: nil))
                return
            }

//            let filter = Filter().toMPFilter(jsonString: filterJson)
            guard let filter = try? JSONDecoder().decode(MPFilter.self, from: filterJson.data(using: .utf8)!) else {
                result(FlutterError(code: "Could not parse filter", message: nil, details: nil))
                return
            }

            
            
            guard let filterBehavior = try? JSONDecoder().decode(MPFilterBehavior.self, from: behaviorJson.data(using: .utf8)!) else {
                result(FlutterError(code: "Could not parse filterBehavior", message: nil, details: nil))
                return
            }
            
            mapsIndoorsData.mapControl?.setFilter(filter: filter, behavior: filterBehavior)
            result(nil)
        }
        
        func setFilterWithLocations(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let locationIds = arguments?["locations"] as? [String] else {
                result(FlutterError(code: "Could not read locations", message: nil, details: nil))
                return
            }

            guard let behaviorJson = arguments?["behavior"] as? String else {
                result(FlutterError(code: "Could not read behavior", message: nil, details: nil))
                return
            }

            guard let filterBehavior = try? JSONDecoder().decode(MPFilterBehavior.self, from: behaviorJson.data(using: .utf8)!) else {
                result(FlutterError(code: "Could not parse filterBehavior", message: nil, details: nil))
                return
            }
            
            let locations = locationIds.compactMap { MPMapsIndoors.shared.locationWith(locationId: $0) }
            mapsIndoorsData.mapControl?.setFilter(locations: locations, behavior: filterBehavior)
            result(nil)
        }
        
        func setMapPadding(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let start = arguments?["start"] as? Int else {
                result(FlutterError(code: "Could not read start", message: nil, details: nil))
                return
            }
            guard let top = arguments?["top"] as? Int else {
                result(FlutterError(code: "Could not read top", message: nil, details: nil))
                return
            }
            guard let end = arguments?["end"] as? Int else {
                result(FlutterError(code: "Could not read end", message: nil, details: nil))
                return
            }
            guard let bottom = arguments?["bottom"] as? Int else {
                result(FlutterError(code: "Could not read start", message: nil, details: nil))
                return
            }

            mapsIndoorsData.googleMap?.padding.top = CGFloat(top)
            mapsIndoorsData.googleMap?.padding.bottom = CGFloat(bottom)
            mapsIndoorsData.googleMap?.padding.left = CGFloat(start)
            mapsIndoorsData.googleMap?.padding.right = CGFloat(end)
            
            result(nil)
        }
        
        func setMapStyle(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: nil, details: nil))
                return
            }
            
            guard let mapStyleJson = args["mapStyle"] else {
                result(FlutterError(code: "Could not read mapStyle", message: nil, details: nil))
                return
            }
            
            guard let mapStyle = try? JSONDecoder().decode(MPMapStyleCodable.self, from: mapStyleJson.data(using: .utf8)!) else {
                result(FlutterError(code: "Could not parse mapStyle", message: nil, details: nil))
                return
            }
            
            mapsIndoorsData.mapControl?.mapStyle = mapStyle
            result(nil)
        }
        
        func showInfoWindowOnClickedLocation(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            //TODO: Not available on mapcontrol. Is this a google map thing?
            result(FlutterError(code: "Not implemented", message: nil, details: nil))
        }
        
        func showUserPosition(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let show = arguments?["show"] as? Bool else {
                result(FlutterError(code: "Could not read show", message: nil, details: nil))
                return
            }
            mapsIndoorsData.mapControl?.showUserPosition = show
            result(nil)
        }
        
        func enableLiveData(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let hasListener = arguments?["listener"] as? Bool else {
                result(FlutterError(code: "Could not read listener", message: nil, details: nil))
                return
            }
            guard let domainType = arguments?["domainType"] as? String else {
                result(FlutterError(code: "Could not read domainType", message: nil, details: nil))
                return
            }
                        
            if(hasListener) {
                if (mapsIndoorsData.liveDataDelegate == nil && mapsIndoorsData.mapControlMethodChannel != nil) {
                    mapsIndoorsData.liveDataDelegate = MapControlLiveDataDelegate(methodChannel: mapsIndoorsData.mapControlMethodChannel!)
                }
                mapsIndoorsData.mapControl?.enableLiveData(domain: domainType, listener: { liveUpdate in
                    mapsIndoorsData.liveDataDelegate?.dataReceived(liveUpdate: liveUpdate)
                })
            } else {
                mapsIndoorsData.mapControl?.enableLiveData(domain: domainType, listener: nil)
            }
            result(nil)
        }
        
        func disableLiveData(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: nil, details: nil))
                return
            }
            
            guard let domainType = args["domainType"] else {
                result(FlutterError(code: "Could not read domainType", message: nil, details: nil))
                return
            }
            mapsIndoorsData.mapControl?.disableLiveData(domain: domainType)
            result(nil)
        }
        
        func moveCamera(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let updateJson = arguments?["update"] as? String else {
                result(FlutterError(code: "Could not read update", message: nil, details: nil))
                return
            }

            guard let cameraUpdate = try? JSONDecoder().decode(CameraUpdate.self, from: updateJson.data(using: .utf8)!) else {
                result(FlutterError(code: "Could not parse cameraUpdate", message: nil, details: nil))
                return
            }

            let duration = arguments?["duration"] as? Int?
            
            //We need to update the camera somehow - determined by the given mode
            let update: GMSCameraUpdate
            
            switch cameraUpdate.mode {
            case "fromPoint":
                guard let point = cameraUpdate.point else {
                    result(FlutterError(code: "fromPoint called without a point", message: nil, details: nil))
                    return
                }
                update = GMSCameraUpdate.setTarget(point.coordinate)
            case "fromBounds":
                guard let bounds = cameraUpdate.bounds else {
                    result(FlutterError(code: "fromBounds called without bounds", message: nil, details: nil))
                    return
                }
                update = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: bounds.northEast, coordinate: bounds.southWest), withPadding: CGFloat(integerLiteral: cameraUpdate.padding!))
            case "zoomBy":
                update = (GMSCameraUpdate.zoom(by: cameraUpdate.zoom!))
            case "zoomTo":
                update = (GMSCameraUpdate.zoom(to: cameraUpdate.zoom!))
            case "fromCameraPosition":
                guard let position = cameraUpdate.position else {
                    result(FlutterError(code: "fromCameraPosition called without a position", message: nil, details: nil))
                    return
                }
                update = (GMSCameraUpdate.setCamera(GMSCameraPosition(latitude: CLLocationDegrees(cameraUpdate.position!.target.latitude), longitude: CLLocationDegrees(position.target.longitude), zoom: position.zoom, bearing: CLLocationDirection(floatLiteral: Double(position.bearing)), viewingAngle: Double(position.tilt)) ))
            default:
                result(FlutterError(code: "Unknown mode", message: nil, details: nil))
                return
            }
            
            if( duration != nil )
            {
                //Animate the camera
                mapsIndoorsData.googleMap?.animate(with: update)
            } else {
                //Move the camera
                mapsIndoorsData.googleMap?.moveCamera(update)
            }
                
            result(nil)
            
            //Internal structs used to decode the camera json above
            struct CameraUpdate: Codable {
                let position: CameraPosition?
                let mode: String
                let point: MPPoint?
                let bounds: MPGeoBounds?
                let padding: Int?
                let width: Int?
                let height: Int?
                let zoom: Float?
            }
            
            struct CameraPosition: Codable {
                let zoom: Float
                let tilt: Float
                let bearing: Float
                let target: MPPoint
            }
        }
        
        func getCurrentCameraPosition(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let cameraPosition = mapsIndoorsData.mapControl?.cameraPosition else {
                result(FlutterError(code: "Could not read cameraPosition", message: nil, details: nil))
                return;
            }
            
            do {
                let jsonData = try JSONEncoder().encode(MPCameraPositionCodable(withCameraPosition: cameraPosition))
                let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
                result(resultJson)
            } catch {
                result(FlutterError(code: "Could not encode cameraPosition", message: nil, details: nil))
            }
        }
    }
}
