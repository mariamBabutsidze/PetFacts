//
//  FactSwipeView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import SwiftUI

struct FactSwipeView: View {
    @State var offset = CGSize.zero
    @State var color: Color = .blue
    @Binding var decisionState: DecisionState
    var fact: Fact
    var swipable: Bool
    
    var body: some View {
        FactView(color: $color, fact: fact)
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double(offset.width/40)))
            .gesture(DragGesture()
                .onChanged { gesture in
                    if swipable {
                        offset = gesture.translation
                        withAnimation {
                            changeColor(width: offset.width)
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeOut) {
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
            color = .red
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            decisionState = .liked
            color = .green
        default:
            offset = .zero
            color = .blue
        }
    }
    
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-100):
            color = .red
        case 100...500:
            color = .green
        default:
            color = .blue
        }
    }
}

#Preview {
    FactSwipeView(decisionState: .constant(.disliked), fact: DogFact.mockDogFact, swipable: true)
}
