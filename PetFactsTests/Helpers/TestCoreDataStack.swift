//
//  TestCoreDataStack.swift
//  PetFactsTests
//
//  Created by Mariam Babutsidze on 15.01.24.
//

import Foundation
import CoreData
@testable import PetFacts

class TestCoreDataStack: CoreDataStack {
    override init(modelName: String = "PetFacts") {
        super.init()
        let container = NSPersistentContainer(
            name: modelName)
        container.persistentStoreDescriptions[0].url =
        URL(fileURLWithPath: "/dev/null")
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError(
                    "Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.storeContainer = container
    }
}
