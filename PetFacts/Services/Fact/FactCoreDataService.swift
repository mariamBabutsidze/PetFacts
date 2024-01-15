//
//  FactCoreDataService.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 15.01.24.
//

import Foundation
import CoreData
import Combine

protocol FactPersistanceService {
    func addFact(_ id: String, text: String) -> Fact?
    func getFacts() -> AnyPublisher<[Fact], Error>
    func delete(_ fact: Fact)
}

final class FactCoreDataService: FactPersistanceService {
    let coreDataStack: CoreDataStack
    private var asyncFetchRequest: NSAsynchronousFetchRequest<FactEntitty>?
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
}

extension FactCoreDataService {
    func addFact(_ id: String, text: String) -> Fact? {
        let fact = FactEntitty(context: coreDataStack.managedContext)
        fact.id = id
        fact.text = text
        coreDataStack.saveContext()
        return fact
    }
    
    func getFacts() -> AnyPublisher<[Fact], Error> {
        let factFetchRequest: NSFetchRequest<FactEntitty> = FactEntitty.fetchRequest()
        let facts = Future<[Fact], Error> { promise in
            self.asyncFetchRequest = NSAsynchronousFetchRequest<FactEntitty>(
                fetchRequest: factFetchRequest
            ) { result in
                guard let facts = result.finalResult else {
                    return promise(.failure(PersistanceError.noValues))
                }
                return promise(.success(facts))
            }
        }.eraseToAnyPublisher()
        do {
            guard let asyncFetchRequest = asyncFetchRequest else {
                return AnyPublisher(Fail<[Fact], Error>(error: PersistanceError.noFetchRequest))
            }
            try coreDataStack.managedContext.execute(asyncFetchRequest)
        } catch let error as NSError {
            Log.coreDataLogger.log(level: .error, "Could not fetch \(error), \(error.userInfo)")
            return AnyPublisher(Fail<[Fact], Error>(error: error))
        }
        return facts
    }
    
    func delete(_ fact: Fact) {
        guard let fact = fact as? FactEntitty else {
          return
        }
        coreDataStack.managedContext.delete(fact)
        coreDataStack.saveContext()
    }
}

