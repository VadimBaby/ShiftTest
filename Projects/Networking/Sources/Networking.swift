//
//  Networking.swift
//  Networking
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//
// swiftlint:disable:next foundation_using
import Foundation

public protocol NetworkingProtocol: AnyObject {
    func fetch<T: Decodable>(returnType: T.Type, router: Router) async throws -> T
}

public final class Networking: NetworkingProtocol {
    private let urlSession = URLSession(configuration: .default)
    
    public init() {}
    
    public func fetch<T: Decodable>(
        returnType: T.Type,
        router: Router
    ) async throws -> T {
        let request = try router.makeURLRequest()
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
           throw NetworkError.invalidResponse
       }
       
       guard (200...299).contains(httpResponse.statusCode) else {
           throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
       }
        
        do {
            let decodedData = try JSONDecoder().decode(returnType, from: data)
            return decodedData
        } catch {
            throw NetworkError.dataConversionFailure
        }
    }
}
