//
//  LikedFactsViewModelTests.swift
//  PetFactsTests
//
//  Created by Mariam Babutsidze on 15.01.24.
//

import XCTest
@testable import PetFacts

final class LikedFactsViewModelTests: XCTestCase {
    let persistance = TestFactPersistance()
    var viewModel: (any LikedFactsViewModelInterface)?

    override func setUp() {
        super.setUp()
        
        viewModel = LikedFactsViewModel(factPersistanceService: persistance)
        _ = persistance.addFact("123", text: "Dogs are smart.")
        _ = persistance.addFact("124", text: "Dogs love playing.")
    }
    
    func testFetchFacts() {
        viewModel?.fetchFacts()
        let facts = persistance.facts
        
        XCTAssertEqual(viewModel?.facts.count, facts.count)
        XCTAssertEqual(viewModel?.facts.first?.id, facts.first?.id)
        XCTAssertEqual(viewModel?.facts[1].id, facts[1].id)
        XCTAssertEqual(viewModel?.showAlert, false)
    }
    
    func testDeleteFact() {
        viewModel?.fetchFacts()
        viewModel?.deleteFact(index: 1)
        let facts = persistance.facts
        
        XCTAssertEqual(viewModel?.facts.count, facts.count)
        XCTAssertEqual(viewModel?.facts.first?.id, facts.first?.id)
        XCTAssertEqual(viewModel?.showAlert, false)
    }
}
