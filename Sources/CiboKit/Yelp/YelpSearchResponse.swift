//
//  YelpSearchResponse.swift
//  
//
//  Created by Ethan Lipnik on 11/6/21.
//

import Foundation

struct YelpSearchResponse: Decodable {
    var businesses: [YelpItem]
}
