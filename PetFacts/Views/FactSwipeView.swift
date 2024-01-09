//
//  FactSwipeView.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import SwiftUI

struct FactSwipeView: View {
    @State var offset = CGSize.zero
    var index = 0
    
    var body: some View {
        FactView()
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double(offset.width/40)))
            .gesture(DragGesture()
                .onChanged { gesture in
                    if index == 0 {
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
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
}

#Preview {
    FactSwipeView()
}
