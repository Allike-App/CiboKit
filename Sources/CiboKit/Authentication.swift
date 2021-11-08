//
//  Authentication.swift
//  
//
//  Created by Ethan Lipnik on 11/6/21.
//

import Foundation

public enum Authentication {
    case yelp(Yelp)
    
    var key: String {
        switch self {
        case .yelp:
            return "yelp"
        }
    }
    
    var credentials: (clientID: String, apiKey: String) {
        switch self {
        case .yelp(let yelp):
            return (yelp.clientID, yelp.apiKey)
        }
    }
}
