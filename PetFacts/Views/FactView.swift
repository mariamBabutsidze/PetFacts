//
//  FactView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 09.01.24.
//

import SwiftUI

struct FactView: View {
    var fact: Fact
    
    var body: some View {
        VStack {
            Text(fact.text)
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
    }
}

#Preview {
    FactView(fact: DogFact.mockDogFact)
}

