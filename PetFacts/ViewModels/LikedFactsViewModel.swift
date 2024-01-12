//
//  LikedFactsViewModel.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 12.01.24.
//

import Combine
import CoreData

final class LikedFactsViewModel: ObservableObject {
    @Published private(set) var facts: [Fact] = []
    @Published public var showAlert = false
    
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
            showAlert = true
            Log.coreDataLogger.log(level: .error, "Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func deleteFact(index: Int) {
        guard let fact = facts[index] as? FactEntitty else {
          return
        }
        CoreDataStack.shared.managedContext.delete(fact)
        CoreDataStack.shared.saveContext()
        facts.remove(at: index)
    }
}



