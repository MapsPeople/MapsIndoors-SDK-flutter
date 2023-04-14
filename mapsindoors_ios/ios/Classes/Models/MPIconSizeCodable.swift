//
//  MPIconSizeCodable.swift
//  MapsIndoorsCodable
//
//  Created by Tim Mikkelsen on 21/03/2023.
//  Copyright © 2023 MapsPeople A/S. All rights reserved.
//

import MapsIndoors

public class MPIconSizeCodable: Codable {
    public var height: Int?
    public var width: Int?
    
    public enum CodingKeys: String, CodingKey {
        case height
        case width
    }

    public init(withCGSize: CGSize) {
        height = Int(withCGSize.height)
        width = Int(withCGSize.width)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        height = try container.decode(Int?.self, forKey: .height)
        width = try container.decode(Int?.self, forKey: .width)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(height, forKey: .height)
        try container.encode(width, forKey: .width)
    }
}
