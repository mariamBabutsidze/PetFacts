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
    @Published private(set) var facts: [Fact] = []
    @Published public var showAlert = false
    @Published private(set) var loading = false
    private(set) var swipable: String?
    public var noFacts: Bool {
        facts.isEmpty && !loading
    }
    
    private let visibleFactCount = 5
    private let factService: FactServicePublisher
    private var factSubscriber: AnyCancellable?
    private var factSubscribers: Set<AnyCancellable> = []
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
        $facts
          .map { _ in false }
          .assign(to: &$loading)
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
        if facts.count > 1 {
            swipable = facts[1].id
        }
        facts.removeFirst()
        Log.generalLogger.debug("removed")
        fetchFact()
    }
    
    public func fetchFacts() {
        if facts.isEmpty {
            loading = true
            factSubscriber = factService.loadFacts(limit: visibleFactCount)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        Log.generalLogger.log(level: .debug, "Publisher completed successfully.")
                    case .failure(let error):
                        self.showAlert = true
                        Log.generalLogger.log(level: .error, "Error: \(error)")
                    }
                }, receiveValue: { value in
                    self.swipable = value.data.first?.id
                    self.facts = value.data
                    Log.generalLogger.log(level: .debug, "Received value: \(String(describing: value))")
                })
        }
    }
    
    private func fetchFact() {
        factService.loadFact()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Log.generalLogger.log(level: .debug, "Publisher completed successfully.")
                case .failure(let error):
                    Log.generalLogger.log(level: .error, "Error: \(error)")
                }
            }, receiveValue: { value in
                if let fact = value.data.first {
                    self.facts.append(fact)
                    Log.generalLogger.debug("new added")
                }
                Log.generalLogger.log(level: .debug, "Received value: \(String(describing: value))")
            })
            .store(in: &factSubscribers)
    }
}


