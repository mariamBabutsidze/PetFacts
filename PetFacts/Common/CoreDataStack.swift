//
//  CoreDataStack.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 11.01.24.
//

import Foundation
import CoreData

class CoreDataStack {
    static var shared = CoreDataStack()
    
    private let modelName: String
    
    init(modelName: String = "PetFacts") {
        self.modelName = modelName
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                Log.coreDataLogger.log(level: .error, "Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext () {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let nserror as NSError {
            Log.coreDataLogger.log(level: .error, "Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

