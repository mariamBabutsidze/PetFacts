//
//  ContentView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 12.01.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FactsView(viewModel: FactsViewModel())
    }
}

#Preview {
    ContentView()
}
