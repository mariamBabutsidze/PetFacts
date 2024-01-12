//
//  FactRouter.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 12.01.24.
//

import SwiftUI

struct FactRouter {
    
    let routers: Routers.FactRouters
    
    @ViewBuilder
    func configure() -> some View {
        switch routers {
        case .favorites:
            LikedFacts()
        }
    }
}
