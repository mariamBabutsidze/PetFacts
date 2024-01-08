//
//  FactRequest.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Foundation

enum FactRequest: RequestProtocol {
    case randomFact
    
    var host: String {
        "dogapi.dog"
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var path: String {
        "/api/v2/facts"
    }

    var requestType: RequestType {
        .GET
    }
}

