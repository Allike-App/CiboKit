//
//  Yelp.swift
//  
//
//  Created by Ethan Lipnik on 11/6/21.
//

import Foundation

public struct Yelp {
    public init(clientID: String, apiKey: String) {
        self.clientID = clientID
        self.apiKey = apiKey
    }
    
    public var clientID: String
    public var apiKey: String
}
