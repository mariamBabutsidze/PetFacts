//
//  Fact.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Foundation

struct DogFacts: Decodable {
    let data: [DogFact]
}

struct DogFact: Decodable, Fact {
    let id: String
    let attributes: Attribute
    
    var text: String {
        attributes.body
    }
}

struct Attribute: Decodable {
    let body: String
}

extension DogFact {
    static let mockDogFact = DogFact(id: "111", attributes: .init(body: "Dogs are smart"))
}
