//
//  FactService.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Foundation
import Combine

struct FactService: FactServicePublisher {
  public func publisher() -> AnyPublisher<Fact, Error> {
      let request = FactRequest.randomFact
      return NetworkingManager.shared.load(request, type: Fact.self)
  }
}

