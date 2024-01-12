//
//  FactEntitty+CoreDataProperties.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 11.01.24.
//
//

import Foundation
import CoreData


extension FactEntitty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FactEntitty> {
        return NSFetchRequest<FactEntitty>(entityName: "FactEntitty")
    }

    @NSManaged public var id: String?
    @NSManaged public var text: String?

}

extension FactEntitty : Identifiable {

}
