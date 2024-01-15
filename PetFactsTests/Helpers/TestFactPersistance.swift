//
//  TestFactPersistance.swift
//  PetFactsTests
//
//  Created by Mariam Babutsidze on 15.01.24.
//

import Foundation
import Combine
@testable import PetFacts

final class TestFactPersistance: FactPersistanceService {
    var facts: [PetFacts.Fact] = []
    
    func addFact(_ id: String, text: String) -> PetFacts.Fact? {
        let fact = PetFacts.DogFact(id: id, attributes: .init(body: text))
        facts.append(fact)
        return fact
    }
    
    func getFacts() -> AnyPublisher<[PetFacts.Fact], Error> {
        return Result.success(facts).publisher.eraseToAnyPublisher()
    }
    
    func delete(_ fact: PetFacts.Fact) {
        facts.removeAll(where: { $0.id == fact.id })
    }
}
