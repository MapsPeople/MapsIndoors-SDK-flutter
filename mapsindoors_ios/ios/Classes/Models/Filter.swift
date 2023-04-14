//
//  Filter.swift
//  mapsindoors_ios
//
//  Created by Martin Hansen on 20/02/2023.
//

import Foundation
import MapsIndoors
import MapsIndoorsCore

public class Filter: Codable {
    public func toMPFilter( jsonString: String ) -> (MPFilter)
    {
        let queryObj: Filter = try! JSONDecoder().decode(Filter.self, from: Data(jsonString.utf8))

        let result = MPFilter()
            
        if(queryObj.take != nil)
        {
            result.take = queryObj.take!
        }
        if(queryObj.skip != nil)
        {
            result.skip = queryObj.skip!
        }
        if(queryObj.floorIndex != nil)
        {
            result.floorIndex = NSNumber(integerLiteral: queryObj.floorIndex!)
        }
        if(queryObj.categories != nil)
        {
            result.categories = queryObj.categories!
        }
        if(queryObj.locations != nil)
        {
            result.locations = queryObj.locations!
        }
        if(queryObj.types != nil)
        {
            result.types = queryObj.types!
        }
        if(queryObj.parents != nil)
        {
            result.parents = queryObj.parents!
        }
        if(queryObj.mapExtend != nil)
        {
            let sw = CLLocationCoordinate2D.init(latitude: CLLocationDegrees(floatLiteral: queryObj.mapExtend!.southwest.latitude),
                                                 longitude: CLLocationDegrees(floatLiteral: queryObj.mapExtend!.southwest.longitude))
            let ne = CLLocationCoordinate2D.init(latitude: CLLocationDegrees(floatLiteral: queryObj.mapExtend!.northeast.latitude),
                                                 longitude: CLLocationDegrees(floatLiteral: queryObj.mapExtend!.northeast.longitude))
            result.bounds = MPGeoBounds(southWest: sw, northEast: ne)
        }
//        if(queryObj.geometry != nil)
//        {
//            result.geometry = queryObj.geometry!
//        }
        if(queryObj.floorIndex != nil)
        {
            result.floorIndex = NSNumber(integerLiteral: queryObj.floorIndex!)
        }
        if(queryObj.depth != nil)
        {
            result.depth = queryObj.depth!
        }
        if(queryObj.ignoreLocationSearchableStatus != nil)
        {
            result.ignoreSearchableStatus = queryObj.ignoreLocationSearchableStatus!
        }
        if(queryObj.ignoreLocationActiveStatus != nil)
        {
            result.ignoreActiveStatus = queryObj.ignoreLocationActiveStatus!
        }
        return result
    }
    
    public var take: Int?
    public var skip: Int?
    public var categories: [String]?
    public var locations: [String]?
    public var types: [String]?
    public var parents: [String]?

    public var mapExtend: geoBounds?
    public var geometry: geoBounds?
    public var floorIndex: Int?
    public var depth: Int?
    public var ignoreLocationSearchableStatus: Bool?
    public var ignoreLocationActiveStatus: Bool?
    
    public struct geoBounds : Codable {
        var northeast: MPPoint
        var southwest: MPPoint
    }
}
