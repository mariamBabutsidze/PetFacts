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
            .onDelete { indexSet in
                for index in indexSet {
                    viewModel.deleteFact(index: index)
                }
            }
        }
        .navigationTitle("Favorites")
        .navigationBarItems(trailing: EditButton())
        .onAppear {
            viewModel.fetchFacts()
        }
    }
}

#Preview {
    LikedFacts()
}
