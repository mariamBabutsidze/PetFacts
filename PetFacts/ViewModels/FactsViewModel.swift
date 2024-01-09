//
//  FactsViewModel.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 09.01.24.
//

import Combine

final class FactsViewModel: ObservableObject {
    public enum DecisionState {
      case disliked, undecided, liked
    }
    
    @Published public var facts: [FactSwipeView] = []
    @Published public var decisionState = DecisionState.undecided
    private let visibleFactCount = 5
    
    public init() {
        
    }
    
    public func addFacts() {
        for i in 0..<visibleFactCount {
            facts.append(FactSwipeView(index: i))
        }
    }
    
    public func reset() {
        
    }
}


