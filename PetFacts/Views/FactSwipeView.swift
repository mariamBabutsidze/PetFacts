//
//  FactSwipeView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import SwiftUI

struct FactSwipeView: View {
    @State var offset = CGSize.zero
    @Binding var decisionState: DecisionState
    var fact: Fact
    var swipable: Bool
    
    var body: some View {
        FactView(fact: fact)
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double(offset.width/40)))
            .gesture(DragGesture()
                .onChanged { gesture in
                    if swipable {
                        offset = gesture.translation
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeFact(width: offset.width)
                    }
                }
            )
    }
    
    func swipeFact(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            decisionState = .disliked
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            decisionState = .liked
        default:
            offset = .zero
        }
    }
}

#Preview {
    FactSwipeView(decisionState: .constant(.disliked), fact: DogFact.mockDogFact, swipable: true)
}
