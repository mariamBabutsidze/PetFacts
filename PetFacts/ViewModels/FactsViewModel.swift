//
//  FactsViewModel.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 09.01.24.
//

import Combine

final class FactsViewModel: ObservableObject {
    @Published public var decisionState = DecisionState.undecided
    @Published public var facts: [Fact] = []
    @Published public var showAlert = false
    
    private let visibleFactCount = 5
    private let factService: FactServicePublisher
    private var factSubscriber: AnyCancellable?
    private var decisionSubscriber: AnyCancellable?
    
    public init(factService: FactServicePublisher = FactService()) {
        self.factService = factService
        decisionSubscriber = $decisionState
            .sink(receiveValue: { decision in
                switch decision {
                case .liked:
                    self.factLiked()
                case .disliked:
                    self.factDisliked()
                default:
                    break
                }
        })
    }
    
    private func factLiked() {
        addFact()
    }
    
    private func factDisliked() {
        addFact()
    }
    
    private func addFact() {
        facts.removeFirst()
        fetchFact()
    }
    
    public func fetchFacts() {
        factSubscriber = factService.loadFacts(limit: visibleFactCount)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Log.networkingLogger.log(level: .debug, "Publisher completed successfully.")
                case .failure(let error):
                    self.showAlert = true
                    Log.networkingLogger.log(level: .error, "Error: \(error)")
                }
            }, receiveValue: { value in
                self.facts = value.data
                Log.networkingLogger.log(level: .debug, "Received value: \(String(describing: value))")
            })
    }
    
    private func fetchFact() {
        factSubscriber = factService.loadFact()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Log.networkingLogger.log(level: .debug, "Publisher completed successfully.")
                case .failure(let error):
                    Log.networkingLogger.log(level: .error, "Error: \(error)")
                }
            }, receiveValue: { value in
                if let fact = value.data.first {
                    self.facts.append(fact)
                }
                Log.networkingLogger.log(level: .debug, "Received value: \(String(describing: value))")
            })
    }
}


