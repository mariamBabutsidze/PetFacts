//
//  FactCoreDataServiceTests.swift
//  PetFactsTests
//
//  Created by Mariam Babutsidze on 15.01.24.
//

import XCTest
@testable import PetFacts
import CoreData

final class FactCoreDataServiceTests: XCTestCase {
    var factService: FactPersistanceService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = TestCoreDataStack()
        factService = FactCoreDataService(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        factService = nil
    }
    
    func testAddFact() {
        let fact = factService.addFact("132", text: "Dogs are awesome.")
        
        XCTAssertNotNil(fact, "Fact should not be nil")
        XCTAssertTrue(fact?.id == "132")
        XCTAssertTrue(fact?.text == "Dogs are awesome.")
    }
    
    func testDeleteFact() {
        let fact = factService.addFact("133", text: "Dogs love humans.")
        factService.delete(fact!)
        let fetchRequest: NSFetchRequest<FactEntitty> = FactEntitty.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "%K = %@",
            argumentArray: [#keyPath(FactEntitty.text), "Dogs love humans."])
        let results: [FactEntitty]?
        do {
            results = try coreDataStack.managedContext.fetch(fetchRequest)
        } catch {
            results = nil
        }
        XCTAssertEqual(results, [])
    }
    
    func testGetFacts() {
        let factOne = factService.addFact("134", text: "Dogs love playing.")
        let factTwo = factService.addFact("135", text: "Dogs are smart.")
        
        let expectation = self.expectation(description: "Awaiting publisher")
        var result: [Fact] = []
        var receivedError: Error? = nil
        
        let cancellable = factService.getFacts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    receivedError = error
                case .finished:
                    break
                }
                expectation.fulfill()
            },
                  receiveValue: { value in
                result = value
            }
            )
        
        waitForExpectations(timeout: 2)
        cancellable.cancel()
        
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.id, factOne?.id)
        XCTAssertEqual(result[1].id, factTwo?.id)
        XCTAssertNil(receivedError, "Error should be nil")
    }
}
