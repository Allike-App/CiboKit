//
//  Coordinates.swift
//  
//
//  Created by Ethan Lipnik on 11/6/21.
//

import Foundation

public struct Coordinates: Codable, Hashable {
    public init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var latitude: Float
    var longitude: Float
}
