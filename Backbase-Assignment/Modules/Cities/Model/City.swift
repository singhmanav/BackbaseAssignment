//
//  File.swift
//  Backbase-Assignment
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//

import Foundation

public struct City: Codable,Comparable {
    var country: String
    var name: String
    var id: Int
    var coord: Location
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case country, name, coord
    }
    public static func < (lhs: City, rhs: City) -> Bool {
        return lhs.name < rhs.name || (lhs.name == rhs.name && lhs.country <= rhs.country)
    }
    
    public static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name && lhs.country <= rhs.country
    }
}

public struct Location: Codable {
    let lat: Double
    let lon: Double
}
