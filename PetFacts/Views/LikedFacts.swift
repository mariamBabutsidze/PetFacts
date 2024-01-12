//
//  LikedFacts.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 11.01.24.
//

import SwiftUI

struct LikedFacts: View {
    @EnvironmentObject private var navigationState: NavigationState
    @ObservedObject private var viewModel = LikedFactsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.facts, id: \.id) { fact in
                Text(fact.text)
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            viewModel.fetchFacts()
        }
    }
}

#Preview {
    LikedFacts()
}
