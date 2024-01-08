//
//  FactViewModel.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Combine

final class FactViewModel: ObservableObject {
    @Published public var fetching = false
    @Published public var fact: Fact?
    
    private let factService: FactServicePublisher
    private var factSubscriber: AnyCancellable?
    
    public init(factService: FactServicePublisher = FactService()) {
        self.factService = factService
        $fact
            .map { _ in false }
            .assign(to: &$fetching)
    }
    
    public func fetchFact() {
        fetching = true
        factSubscriber = factService.loadFact()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Log.networkingLogger.log(level: .debug, "Publisher completed successfully.")
                case .failure(let error):
                    Log.networkingLogger.log(level: .error, "Error: \(error)")
                }
            }, receiveValue: { value in
                self.fact = value.data.first
                Log.networkingLogger.log(level: .debug, "Received value: \(String(describing: value))")
            })
    }
    
    public func reset() {
        
    }
}

