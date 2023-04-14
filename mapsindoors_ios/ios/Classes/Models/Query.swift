//
//  Query.swift
//  mapsindoors_ios
//
//  Created by Martin Hansen on 20/02/2023.
//

import Foundation
import MapsIndoors

public class Query: Codable {
    public func toMPQuery( jsonString: String ) -> (MPQuery)
    {
        let queryObj: Query = try! JSONDecoder().decode(Query.self, from: Data(jsonString.utf8))

        let result = MPQuery()
        if(queryObj.query != nil)
        {
            result.query = queryObj.query!
        }
        result.near = MPPoint()
        return result
    }
    public var query: String?
    public var near: MPPoint?
    public var queryProperties: [String]?
}
