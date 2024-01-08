//
//  FactServicePublisher.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Combine
import Foundation

protocol FactServicePublisher {
  func publisher() -> AnyPublisher<Fact, Error>
}

