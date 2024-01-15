//
//  LikedFactsViewModel.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 12.01.24.
//

import Combine

final class LikedFactsViewModel: ObservableObject {
    @Published private(set) var facts: [Fact] = []
    @Published var showAlert = false
    
    private let factPersistanceService: FactPersistanceService
    private var factSubscriber: AnyCancellable?
    
    init(factPersistanceService: FactPersistanceService = FactCoreDataService()) {
        self.factPersistanceService = factPersistanceService
    }
    
    func fetchFacts() {
        factSubscriber = factPersistanceService.getFacts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Log.generalLogger.log(level: .debug, "Publisher completed successfully.")
                case .failure(let error):
                    self.showAlert = true
                    Log.generalLogger.log(level: .error, "Error: \(error)")
                }
            }, receiveValue: { facts in
                self.facts = facts
            })
    }
    
    func deleteFact(index: Int) {
        let fact = facts[index]
        factPersistanceService.delete(fact)
        facts.remove(at: index)
    }
}



