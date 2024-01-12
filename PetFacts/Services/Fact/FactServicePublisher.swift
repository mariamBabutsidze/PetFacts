//
//  FactServicePublisher.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Combine
import Foundation

protocol FactServicePublisher {
    func loadFact() -> AnyPublisher<DogFacts, Error>
    func loadFacts(limit: Int) -> AnyPublisher<DogFacts, Error>
}

