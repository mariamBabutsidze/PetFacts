//
//  ContentView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = FactViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(viewModel.fact?.attributes.body ?? "No Value")
        }
        .padding()
        .onAppear {
            viewModel.fetchFact()
        }
    }
}

#Preview {
    ContentView()
}
