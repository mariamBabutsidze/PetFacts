//
//  Fact.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Foundation

struct Facts: Decodable {
    let data: [Fact]
}

struct Fact: Decodable {
    let id: String
    let attributes: Attribute
}

struct Attribute: Decodable {
    let body: String
}

extension Fact {
    static let mockFact = Fact(id: "111", attributes: .init(body: "Dogs are smart"))
}
