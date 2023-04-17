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
import MapsIndoorsCodable
import MapsIndoorsGoogleMaps
import MapsIndoorsCodable
import GoogleMaps
import MapsIndoorsCodable

public class MapsIndoorsMethodChannel: NSObject {
    
    enum Methods: String {
        case MIN_initialize
        case MIN_locationDisplayRuleExists
        case MIN_displayRuleNameExists
        case MIN_checkOfflineDataAvailability
        case MIN_destroy
        case MIN_disableEventLogging
        case MIN_getAPIKey
        case MIN_getAvailableLanguages
        case MIN_getBuildings
        case MIN_getCategories
        case MIN_getDataSet
        case MIN_getDefaultLanguage
        case MIN_getLanguage
        case MIN_getLocationById
        case MIN_getLocations
        case MIN_getLocationsByExternalIds
        case MIN_getLocationsByQuery
        case MIN_getMapStyles
        case MIN_getSolution
        case MIN_getVenues
        case MIN_isAPIKeyValid
        case MIN_isInitialized
        case MIN_isReady
        case MIN_setLanguage
        case MIN_synchronizeContent
        case MIN_applyUserRoles
        case MIN_getAppliedUserRoles
        case MIN_getUserRoles
        case MIN_reverseGeoCode
        case MIN_setPositionProvider
        case MIN_getDefaultVenue
        
        func call(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            let runner: (_ arguments: [String: Any]?, _ mapsIndoorsData: MapsIndoorsData, _ result: @escaping FlutterResult) -> Void
            
            switch self {
            case .MIN_initialize:                   runner = initialize
            case .MIN_locationDisplayRuleExists:    runner = locationDisplayRuleExists
            case .MIN_displayRuleNameExists:        runner = displayRuleNameExists
            case .MIN_checkOfflineDataAvailability: runner = checkOfflineDataAvailability
            case .MIN_destroy:                      runner = destroy
            case .MIN_disableEventLogging:          runner = disableEventLogging
            case .MIN_getAPIKey:                    runner = getAPIKey
            case .MIN_getAvailableLanguages:        runner = getAvailableLanguages
            case .MIN_getBuildings:                 runner = getBuildings
            case .MIN_getCategories:                runner = getCategories
            case .MIN_getDataSet:                   runner = getDataSet
            case .MIN_getDefaultLanguage:           runner = getDefaultLanguage
            case .MIN_getLanguage:                  runner = getLanguage
            case .MIN_getLocationById:              runner = getLocationById
            case .MIN_getLocations:                 runner = getLocations
            case .MIN_getLocationsByExternalIds:    runner = getLocationsByExternalIds
            case .MIN_getLocationsByQuery:          runner = getLocationsByQuery
            case .MIN_getMapStyles:                 runner = getMapStyles
            case .MIN_getSolution:                  runner = getSolution
            case .MIN_getVenues:                    runner = getVenues
            case .MIN_isAPIKeyValid:                runner = isAPIKeyValid
            case .MIN_isInitialized:                runner = isInitialized
            case .MIN_isReady:                      runner = isReady
            case .MIN_setLanguage:                  runner = setLanguage
            case .MIN_synchronizeContent:           runner = synchronizeContent
            case .MIN_applyUserRoles:               runner = applyUserRoles
            case .MIN_getAppliedUserRoles:          runner = getAppliedUserRoles
            case .MIN_getUserRoles:                 runner = getUserRoles
            case .MIN_reverseGeoCode:               runner = reverseGeoCode
            case .MIN_setPositionProvider:          runner = setPositionProvider
            case .MIN_getDefaultVenue:              runner = getDefaultVenue
            }
            
            runner(arguments, mapsIndoorsData, result)
        }
        
        func initialize(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            
            guard let args = arguments else {
                result(FlutterError(code: "Initialized called without arguments", message: "MIN_initialize", details: nil))
                return
            }
            
            guard let apiKey = args["key"] as? String else {
                result(FlutterError(code: "Could not initialise MapsIndoors", message: "MIN_initialize", details: nil))
                return
            }

            Task {
                do {
                    try await MPMapsIndoors.shared.load(apiKey: apiKey)
                    result(nil)
                }
                catch {
                    result("{\"code\": 1000,\"message\": " + "\"" + error.localizedDescription + "\"" + "}")
                }
            }
        }
        
        func locationDisplayRuleExists(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: "MIN_locationDisplayRuleExists", details: nil))
                return
            }
            
            guard let locationId = args["id"] else {
                result(FlutterError(code: "Could not read locationId", message: "MIN_locationDisplayRuleExists", details: nil))
                return
            }
            
            guard let loc = MPMapsIndoors.shared.locationWith(locationId: locationId) else {
                result(FlutterError(code: "Could not find any location with the given locationId", message: "MIN_locationDisplayRuleExists", details: nil))
                return
            }
            
            result ( MPMapsIndoors.shared.displayRuleFor(location: loc) != nil )
        }
        
        func displayRuleNameExists(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: "MIN_displayRuleNameExists", details: nil))
                return
            }
            
            guard let typeName = args["name"] else {
                result(FlutterError(code: "Could not read name", message: "MIN_displayRuleNameExists", details: nil))
                return
            }
            //Return true if getdisplayRuleType can find a type with the given name
            result ( getdisplayRuleType(name: typeName) != nil)
        }
        
        func getdisplayRuleType(name: String) -> MPDisplayRuleType? {
            switch name {
            case "buildingOutline":
                return MPDisplayRuleType.buildingOutline
            case "selectionHighlight":
                return MPDisplayRuleType.selectionHighlight
            case "positionIndicator":
                return MPDisplayRuleType.blueDot
            case "main":
                return MPDisplayRuleType.main
            case "default":
                return MPDisplayRuleType.default
            default:
                return nil
            }
        }
        
        func removeDisplayRuleForLocation(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            //            guard let args = arguments as? [String: String] else {
            //                result(FlutterError(code: "Could not read arguments", message: nil, details: nil))
            //                return
            //            }
            //
            //            guard let locationId = args["id"] else {
            //                result(FlutterError(code: "Could not read locationId", message: nil, details: nil))
            //                return
            //            }
            //
            //            guard let location = MPMapsIndoors.shared.locationWith(locationId: locationId) else {
            //                result(FlutterError(code: "Could not find a location with the given locationId", message: nil, details: nil))
            //                return
            //            }
            
            //TODO: Not implemented on android and test is commented out
            result(FlutterError(code: "Not implemented - Neither on Android nor IOS", message: nil, details: nil))
        }
        
        func checkOfflineDataAvailability(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                guard let apikey = MPMapsIndoors.shared.apiKey else {
                    result(FlutterError(code: "APIKey not set", message: "MIN_checkOfflineDataAvailability", details: nil))
                    return
                }
                result(await MPMapsIndoors.shared.isOfflineDataAvailable(apiKey: apikey) ? "true" : "false")
            }
        }
        
        func destroy(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            MPMapsIndoors.shared.shutdown()
        }
        
        func disableEventLogging(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let disable = arguments?["disable"] as? Bool else {
                result(FlutterError(code: "Could not read disable", message: "MIN_disableEventLogging", details: nil))
                return
            }
            MPMapsIndoors.shared.eventLoggingDisabled = disable
        }
        
        func getAPIKey(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            result(MPMapsIndoors.shared.apiKey)
        }
        
        func getAvailableLanguages(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            result(MPMapsIndoors.shared.solution?.availableLanguages)
        }
        
        func getBuildings(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                let buildings = await MPMapsIndoors.shared.buildings();
                let jsonData = try JSONEncoder().encode(buildings.map {MPBuildingCodable(withBuilding: $0) })
                result(String(data: jsonData, encoding: String.Encoding.utf8));
            }
        }
        
        func getCategories(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                let categories = await MPMapsIndoors.shared.categories();
                let jsonData = try JSONEncoder().encode(categories.map {MPDataFieldCodable(withDataField: $0) })
                result(String(data: jsonData, encoding: String.Encoding.utf8));
            }
        }
        
        func getDataSet(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let solution = MPMapsIndoors.shared.solution else {
                result(FlutterError(code: "No dataset found", message: "MIN_getDataSet", details: nil))
                return
            }
            
            let jsonData = try! JSONEncoder().encode(MPSolutionCodable(withSolution: solution))
            result(String(data: jsonData, encoding: String.Encoding.utf8));
        }
        
        func getDefaultLanguage(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            result(MPMapsIndoors.shared.solution?.defaultLanguage)
        }
        
        func getLanguage(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            result(MPMapsIndoors.shared.language)
        }
        
        func getLocationById(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: "MIN_getLocationById", details: nil))
                return
            }
            
            guard let locationId = args["id"] else {
                result(FlutterError(code: "Could not read locationId", message: "MIN_getLocationById", details: nil))
                return
            }
            
            guard let location = MPMapsIndoors.shared.locationWith(locationId: locationId) else {
                result(FlutterError(code: "Could not find location with the given locationId", message: "MIN_getLocationById", details: nil))
                return
            }
            
            let jsonData = try! JSONEncoder().encode(MPLocationCodable(withLocation: location))
            
            let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
            result(resultJson);
        }
        
        func getLocations(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task
            {
                let query = MPQuery()
                let filter = MPFilter()
                
                let locations = await MPMapsIndoors.shared.locationsWith(query: query, filter: filter);
                let locationsCodable = locations.map {MPLocationCodable(withLocation: $0) }
                
                let jsonData = try JSONEncoder().encode(locationsCodable)
                let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
                
                result(resultJson);
            }
        }
        
        func getLocationsByExternalIds(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let locationIds = arguments?["ids"] as? [String] else {
                result(FlutterError(code: "Could not read locationId", message: "MIN_getLocationsByExternalIds", details: nil))
                return
            }
            
            let locations = MPMapsIndoors.shared.locationsWith(externalIds: locationIds)
            let locationsCodable = locations.map {MPLocationCodable(withLocation: $0) }
            
            let jsonData = try! JSONEncoder().encode(locationsCodable)
            let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
            
            result(resultJson);
        }
        
        func getLocationsByQuery(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task
            {
                guard let args = arguments as? [String: String] else {
                    result(FlutterError(code: "Could not read arguments", message: "MIN_getLocationsByQuery", details: nil))
                    return
                }

                guard let queryJson = args["query"] else {
                    result(FlutterError(code: "Could not read query", message: "MIN_getLocationsByQuery", details: nil))
                    return
                }

                guard var filterJson = args["filter"] else {
                    result(FlutterError(code: "Could not read filter", message: "MIN_getLocationsByQuery", details: nil))
                    return
                }

//                filterJson = "{\"take\":3,\"skip\":20,\"depth\":2,\"floorIndex\":10,\"categories\":[\"one\",\"two\"],\"locations\":[\"location\"],\"types\":null,\"parents\":[\"venue\"],\"mapExtend\":{\"northeast\":{\"coordinates\":[56.55467,91.2345234],\"type\":\"Point\"},\"southwest\":{\"coordinates\":[-45.213342634,-20.4234],\"type\":\"Point\"}},\"geometry\":{\"northeast\":{\"coordinates\":[89.0,90.0],\"type\":\"Point\"},\"southwest\":{\"coordinates\":[1.0,2.0],\"type\":\"Point\"}},\"ignoreLocationSearchableStatus\":false,\"ignoreLocationActiveStatus\":true}"

                
                let query = Query().toMPQuery(jsonString: queryJson)
                let filter = Filter().toMPFilter(jsonString: filterJson)
                
                let locations = await MPMapsIndoors.shared.locationsWith(query: query, filter: filter);
                let locationsCodable = locations.map {MPLocationCodable(withLocation: $0) }
                
                let jsonData = try JSONEncoder().encode(locationsCodable)
                let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
                
                //let resultJson = "[{\"entityIsPoint\":true,\"position\":[9.9507192892242298,57.059049474943897,40],\"building\":\"stigsborgvej\",\"id\":\"dbb7aaa843fd4bfcae6b4268\",\"name\":\"4\",\"restrictions\":[],\"aliases\":[],\"type\":\"FLOOR\",\"imageURL\":\"\",\"floorName\":\"\",\"iconUrl\":\"https:\\/\\/null.com\",\"properties\":{},\"baseType\":3,\"entityBounds\":{\"northEast\":[9.9512968063354492,57.058494567871094],\"southWest\":[9.9501094818115234,57.057834625244141]},\"venue\":\"stigsborgvej\",\"coordinateBounds\":{\"northEast\":[9.9512968063354492,57.058494567871094],\"southWest\":[9.9501094818115234,57.057834625244141]},\"isBookable\":false,\"floorIndex\":40,\"entityPosition\":[9.9507192892242298,57.059049474943897,40],\"locationDescription\":\"\",\"externalId\":\"\",\"categories\":[\"FLOOR\"]}]"
                
                result(resultJson);
            }
        }
        
        func getMapStyles(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                guard let defaultVenue = await MPMapsIndoors.shared.venues().first else {
                    result(FlutterError(code: "Could not get default venue", message: "MIN_getMapStyles", details: nil))
                    return
                }
                
                //Use the current venue (if available) or fallback to the default venue
                let venue = mapsIndoorsData.mapControl?.currentVenue ?? defaultVenue
                
                //If there are no mapstyles just return an empty array
                guard let mapStyles = venue.styles else {
                    result("[]")
                    return
                }
                
                let jsonData = try! JSONEncoder().encode( mapStyles.map { MPMapStyleCodable(withMapStyle: $0)} )
                result(String(data: jsonData, encoding: String.Encoding.utf8));
            }
        }
        
        func getSolution(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let solution = MPMapsIndoors.shared.solution else {
                result(FlutterError(code: "Solution not found", message: "MIN_getSolution", details: nil))
                return
            }
            
            let jsonData = try! JSONEncoder().encode(MPSolutionCodable(withSolution: solution))
            result(String(data: jsonData, encoding: String.Encoding.utf8));
        }
        
        func getVenues(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                let venues = await MPMapsIndoors.shared.venues();
                let jsonData = try JSONEncoder().encode(venues.map { MPVenueCodable(withVenue: $0) })
                let venueJson = String(data: jsonData, encoding: String.Encoding.utf8)
                result(venueJson);
            }
        }
        
        func isAPIKeyValid(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                guard let apiKey = MPMapsIndoors.shared.apiKey else {
                    result(FlutterError(code: "Apikey not set", message: "MIN_isAPIKeyValid", details: nil))
                    return
                }
                let isValid = await MPMapsIndoors.shared.isApiKeyValid(apiKey: apiKey)
                result(isValid)
            }
        }
        
        func isInitialized(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            result(nil)
        }
        
        func isReady(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            result(MPMapsIndoors.shared.ready)
        }
        
        func setLanguage(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: "MIN_setLanguage", details: nil))
                return
            }
            
            guard let language = args["language"] else {
                result(FlutterError(code: "Could not read language argument", message: "MIN_setLanguage", details: nil))
                return
            }
            MPMapsIndoors.shared.language = language
            result(nil)
        }
        
        func synchronizeContent(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                let _ = try await MPMapsIndoors.shared.synchronize()
                result(nil)
            }
        }
        
        func applyUserRoles(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let args = arguments as? [String: String] else {
                result(FlutterError(code: "Could not read arguments", message: "MIN_applyUserRoles", details: nil))
                return
            }
            
            guard let userRolesJson = args["userRoles"] else {
                result(FlutterError(code: "Could not read userRoles argument", message: "MIN_applyUserRoles", details: nil))
                return
            }
            
            do {
                let userRoles = try JSONDecoder().decode([MPUserRole].self, from: Data(userRolesJson.utf8))
                MPMapsIndoors.shared.userRoles = userRoles
                result(nil)
            } catch {
                result(FlutterError(code: "Unable to read userroles", message: "MIN_applyUserRoles", details: nil))
            }
        }
        
        func getAppliedUserRoles(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            do {
                let jsonData = try JSONEncoder().encode([MPUserRole](MPMapsIndoors.shared.userRoles))
                let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
                result(resultJson)
            } catch {
                result(FlutterError(code: "Could not encode userroles", message: "MIN_getAppliedUserRoles", details: nil))
            }
        }
        
        func getUserRoles(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            do {
                let jsonData = try JSONEncoder().encode([MPUserRole](MPMapsIndoors.shared.availableUserRoles))
                let resultJson = String(data: jsonData, encoding: String.Encoding.utf8)
                result(resultJson)
            } catch {
                result(FlutterError(code: "Could not encode userroles", message: "MIN_getUserRoles", details: nil))
            }
        }
        
        func reverseGeoCode(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let pointJson = arguments?["point"] as? String else {
                result(FlutterError(code: "Could not read point", message: "MIN_reverseGeoCode", details: nil))
                return
            }
            
            do {
                let point = try JSONDecoder().decode(MPPoint.self, from: Data(pointJson.utf8))
            } catch {
                result(FlutterError(code: "Unable to read userroles", message: "MIN_reverseGeoCode", details: nil))
            }
            
            //TODO: reverseGeoCode does not exists on IOS. Sorry.
            result(FlutterError(code: "Not implemented as it's not available in IOS", message: nil, details: nil))
        }
        
        func setPositionProvider(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            
            guard let remove = arguments?["remove"] as? Bool else {
                result(FlutterError(code: "Could not read arguments", message: "MIN_setPositionProvider", details: nil))
                return
            }
            
            guard let name = arguments?["name"] as? String else {
                result(FlutterError(code: "Could not read arguments", message: "MIN_setPositionProvider", details: nil))
                return
            }
            
            if(remove) {
                mapsIndoorsData.positionProvider = nil
                mapsIndoorsData.mapControl?.positionProvider = nil
            } else {
                let provider = FlutterPositionProvider()
                provider.name = name
                mapsIndoorsData.positionProvider = provider
                mapsIndoorsData.mapControl?.positionProvider = provider
            }
        }
        
        func getDefaultVenue(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            Task {
                guard let defaultVenue = await MPMapsIndoors.shared.venues().first else {
                    result(FlutterError(code: "Could not get default venue", message: "MIN_getDefaultVenue", details: nil))
                    return
                }
                let jsonData = try! JSONEncoder().encode( MPVenueCodable(withVenue: defaultVenue) )
                result(String(data: jsonData, encoding: String.Encoding.utf8));
            }
        }
    }
}
