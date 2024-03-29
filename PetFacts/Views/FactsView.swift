//
//  FactsView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 09.01.24.
//

import SwiftUI

struct FactsView<ViewModel>: View where ViewModel: FactsViewModelInterface {
    @ObservedObject private var viewModel: ViewModel
    @EnvironmentObject private var navigationState: NavigationState
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.noFacts {
                Text("Oops, looks like there are no facts left!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .multilineTextAlignment(.center)
            }
            ZStack {
                ForEach(viewModel.facts.reversed(), id: \.id) { fact in
                    let index = viewModel.facts.firstIndex(where: { $0.id == fact.id }) ?? .zero
                    FactSwipeView(decisionState: $viewModel.decisionState, fact: fact, swipable: viewModel.swipable == fact.id)
                        .stacked(at: index, in: viewModel.facts.count)
                }
            }
            if viewModel.loading {
                ProgressView() {
                    Text("Loading...")
                }
            }
        }
        .padding()
        .padding(.bottom, 40)
        .toolbar {
            Button("", systemImage: "heart.fill", action: {
                navigationState.routers.append(.fact(.favorites))
            })
        }
        .navigationTitle("Pet Facts")
        .navigationBarTitleDisplayMode(.inline)
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
    FactsView(viewModel: FactsViewModel())
}
