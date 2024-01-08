//
//  NetworkingManager.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Foundation
import Combine
import OSLog

public protocol NetworkingManagerProtocol {
    func load<T: Decodable>(_ request: RequestProtocol, type: T.Type) -> AnyPublisher<T, Error>
}

final class NetworkingManager: NetworkingManagerProtocol {
    static var shared = NetworkingManager()
    
    private let urlSession: URLSession
    private let decoder = JSONDecoder()
    
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
        decoder.dateDecodingStrategy = .millisecondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func load<T: Decodable>(_ request: RequestProtocol, type: T.Type) -> AnyPublisher<T, Error> {
        do {
            let urlRequest = try request.createURLRequest()
            return urlSession.dataTaskPublisher(for: urlRequest)
                .tryMap { element -> Data in
                    guard let urlResponse = element.response as? HTTPURLResponse, urlResponse.statusCode == 200
                    else {
                        Log.networkingLogger.log(level: .error, "invalid response")
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: T.self, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            Log.networkingLogger.log(level: .error, "invalid url")
            return AnyPublisher(Fail<T, Error>(error: NetworkError.invalidUrl))
        }
    }
}
