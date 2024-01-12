//
//  FactsViewModel.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 09.01.24.
//

import Combine
import CoreData

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
        saveToFavorites()
        addNewFact()
    }
    
    private func factDisliked() {
        addNewFact()
    }
    
    private func saveToFavorites() {
        guard let likedFact = facts.first else {
            return
        }
        let factEntity = FactEntitty(context: CoreDataStack.shared.managedContext)
        factEntity.id = likedFact.id
        factEntity.text = likedFact.text
        CoreDataStack.shared.saveContext()
    }
    
    private func addNewFact() {
        facts.removeFirst()
        fetchFact()
    }
    
    public func fetchFacts() {
        if facts.isEmpty {
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


