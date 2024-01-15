//
//  RequestProtocol.swift
//  PetFacts
//
//  Created by Mariam Babutsidze on 08.01.24.
//

import Foundation

protocol RequestProtocol {
    var host: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var body: [String: Any] { get }
    var query: [String: String?] { get }
    var requestType: RequestType { get }
    var port: Int? { get }
    var scheme: Scheme { get }
}

enum Scheme: String {
    case http
    case https
}

extension RequestProtocol {
    var scheme: Scheme {
        .https
    }
    
    var body: [String: Any] {
      [:]
    }
    
    var query: [String: String?] {
      [:]
    }
    
    var headers: [String: String] {
      [:]
    }
    
    var port: Int? {
        nil
    }
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        components.port = port
        
        if !query.isEmpty {
            components.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !body.isEmpty && request.httpMethod != RequestType.GET.rawValue {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        return request
    }
}

