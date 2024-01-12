//
//  Routers.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 12.01.24.
//

enum Routers: Hashable {
    case fact(FactRouters)
    
    enum FactRouters: Hashable {
        case favorites
    }
}
