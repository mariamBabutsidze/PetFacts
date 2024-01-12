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
        .overlay(Group {
            if viewModel.facts.isEmpty {
                Text("Oops, looks like you don't have favorite facts!")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }
        })
        .navigationTitle("Favorites")
        .navigationBarItems(trailing: EditButton())
        .onAppear {
            viewModel.fetchFacts()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Something went wrong."),
                dismissButton: .cancel()
            )
        }
    }
}

#Preview {
    LikedFacts()
}
