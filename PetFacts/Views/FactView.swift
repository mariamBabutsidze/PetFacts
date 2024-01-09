//
//  FactView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 09.01.24.
//

import SwiftUI

struct FactView: View {
    @ObservedObject private var viewModel = FactViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.fact?.attributes.body ?? "No Value")
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Rectangle()
                        .foregroundStyle(.ultraThinMaterial)
                        .background(.blue)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
        }
        .padding()
        .onAppear {
            viewModel.fetchFact()
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
    FactView()
}

