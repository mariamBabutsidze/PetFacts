//
//  PetFactsApp.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import SwiftUI

@main
struct PetFactsApp: App {
    @StateObject private var navigationState = NavigationState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationState.routers) {
                ContentView()
                    .navigationDestination(for: Routers.self) { router in
                        switch router {
                        case .fact(let routers):
                            FactRouter(routers: routers).configure()
                        }
                    }
            }.environmentObject(navigationState)
        }
    }
}
