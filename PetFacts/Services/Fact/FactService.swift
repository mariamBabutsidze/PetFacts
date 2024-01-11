//
//  FactService.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Foundation
import Combine

struct FactService: FactServicePublisher {
    public func loadFact() -> AnyPublisher<Facts, Error> {
        let request = FactRequest.randomFact
        return NetworkingManager.shared.load(request, type: Facts.self)
    }
    
    public func loadFacts(limit: Int) -> AnyPublisher<Facts, Error> {
        let request = FactRequest.facts(limit: limit)
        return NetworkingManager.shared.load(request, type: Facts.self)
    }
}

