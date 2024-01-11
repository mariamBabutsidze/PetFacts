//
//  FactsView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 09.01.24.
//

import SwiftUI

struct FactsView: View {
    @ObservedObject private var viewModel = FactsViewModel()
    
    var body: some View {
        ZStack {
            ForEach(viewModel.facts.reversed(), id: \.id) { fact in
                let index = viewModel.facts.firstIndex(where: { $0.id == fact.id }) ?? .zero
                FactSwipeView(decisionState: $viewModel.decisionState, fact: fact, swipable: index == 0)
                    .stacked(at: index, in: viewModel.facts.count)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Something went wrong."),
                dismissButton: .cancel()
            )
        }
        .onAppear{
            viewModel.fetchFacts()
        }
    }
}

#Preview {
    FactsView()
}
