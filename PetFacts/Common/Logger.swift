//
//  Logger.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import os

enum Log {
    static let networkingLogger = Logger(subsystem: "com.Mariam.PetFacts", category: "networking")
    static let generalLogger = Logger(subsystem: "com.Mariam.PetFacts", category: "general")
}
