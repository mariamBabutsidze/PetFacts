//
//  FactRequest.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Foundation

enum FactRequest: RequestProtocol {
    case randomFact
    case facts(limit: Int)
    
    var host: String {
        "dogapi.dog"
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var path: String {
        "/api/v2/facts"
    }
    
    var query: [String : String?] {
        switch self {
        case .facts(let limit):
            return ["limit": String(limit)]
        case .randomFact:
            return [:]
        }
        
    }

    var requestType: RequestType {
        .GET
    }
}

