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
            ForEach(viewModel.facts.reversed(), id: \.index) { fact in
                fact
                    .stacked(at: fact.index, in: viewModel.facts.count)
            }
        }
        .onAppear{
            viewModel.addFacts()
        }
    }
}

#Preview {
    FactsView()
}
