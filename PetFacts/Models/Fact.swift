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
    let attributes: Attribute
}

struct Attribute: Decodable {
    let body: String
}
