//
//  FactView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 09.01.24.
//

import SwiftUI

struct FactView: View {
    @Binding var color: Color
    var fact: Fact
    
    var body: some View {
        VStack {
            Text(fact.text)
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding()
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Rectangle()
                        .foregroundStyle(.ultraThinMaterial)
                        .background(color)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
        }
        .padding()
    }
}

#Preview {
    FactView(color: .constant(.blue), fact: DogFact.mockDogFact)
}

