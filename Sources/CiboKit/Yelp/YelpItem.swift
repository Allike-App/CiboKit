//
//  YelpItem.swift
//  
//
//  Created by Ethan Lipnik on 11/6/21.
//

import Foundation

struct YelpItem: Identifiable, Decodable {
    var id,
        phone,
        alias,
        name: String
    var price: String?
    var coordinates: Coordinates
    var imageURL: String?
    var distance,
        rating: Float
    var categories: [Category]
    var location: Self.Location
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case phone
        case alias
        case name
        case coordinates
        case imageURL = "image_url"
        case distance
        case rating
        case categories
        case location
        case price
        case url
    }
    
    struct Category: Decodable {
        var alias,
            title: String
    }
    
    struct Location: Decodable {
        var address1,
            address2,
            address3: String?
        var city,
            country,
            state,
            zipCode: String
        
        enum CodingKeys: String, CodingKey {
            case address1
            case address2
            case address3
            case city
            case country
            case state
            case zipCode = "zip_code"
        }
    }
}
