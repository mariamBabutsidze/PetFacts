//
//  LikedFactsViewModel.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 12.01.24.
//

import Combine
import CoreData

final class LikedFactsViewModel: ObservableObject {
    @Published public var facts: [Fact] = []
    
    private var asyncFetchRequest: NSAsynchronousFetchRequest<FactEntitty>?
    
    init() {
        let factFetchRequest: NSFetchRequest<FactEntitty> = FactEntitty.fetchRequest()
        asyncFetchRequest = NSAsynchronousFetchRequest<FactEntitty>(
            fetchRequest: factFetchRequest
        ) { [unowned self] result in
            guard let facts = result.finalResult else {
                return
            }
            self.facts = facts
        }
        
    }
    
    func fetchFacts() {
        do {
            guard let asyncFetchRequest = asyncFetchRequest else {
                return
            }
            try CoreDataStack.shared.managedContext.execute(asyncFetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}


