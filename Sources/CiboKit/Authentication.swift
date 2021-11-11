//
//  Authentication.swift
//  
//
//  Created by Ethan Lipnik on 11/6/21.
//

import Foundation

public enum Authentication {
    case yelp(clientID: String, apiKey: String)
    
    var key: String {
        switch self {
        case .yelp:
            return "yelp"
        }
    }
}
