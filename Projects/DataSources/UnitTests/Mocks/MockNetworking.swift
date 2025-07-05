//
//  MockNetworking.swift
//  DataSources
//
//  Created by Вадим Мартыненко on 05.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
@testable import Networking
@testable import Domain
@testable import DataSources

final class MockNetworking: NetworkingProtocol {
    private let configuration: Configuration
    
    private(set) var didCallFetch = false
    
    enum Configuration {
        case success, empty, longDelay, wrongData
    }
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    private enum Endpoint: String {
        case products
    }
    
    func fetch<T: Decodable>(returnType: T.Type, router: Router) async throws -> T {
        self.didCallFetch = true
        
        switch configuration {
        case .success:
            return try await handleSuccess(returnType: returnType, router: router)
        case .empty:
            return try await handleEmpty(returnType: returnType)
        case .longDelay:
            return try await handleLongDelay(returnType: returnType, router: router)
        case .wrongData:
            return try await handleWrongData(returnType: returnType)
        }
    }
    
    func getSuccessProducts() -> [ServerProduct] {
        return (1...30).map{ ServerProduct(id: $0, title: "Title", price: 111) }
    }
    
    private func handleSuccess<T: Decodable>(returnType: T.Type, router: Router) async throws -> T {
        guard let endpoint = Endpoint(rawValue: router.endpoint) else { throw URLError(.badURL) }
        let data = try getData(for: endpoint)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func handleEmpty<T: Decodable>(returnType: T.Type) async throws -> T {
        return try JSONDecoder().decode(T.self, from: Data())
    }
    
    private func handleLongDelay<T: Decodable>(returnType: T.Type, router: Router) async throws -> T {
        try? await Task.sleep(nanoseconds: 7_000_000_000)
        return try await handleSuccess(returnType: returnType, router: router)
    }
    
    private func handleWrongData<T: Decodable>(returnType: T.Type) async throws -> T {
        let strings = (0...30).map{ $0.description }
        let wrongData = try JSONEncoder().encode(strings)
        return try JSONDecoder().decode(T.self, from: wrongData)
    }
    
    private func getData(for endpoint: Endpoint) throws -> Data {
        switch endpoint {
        case .products: try getProductsData()
        }
    }
}

// MARK: - Private Methods

private extension MockNetworking {
    func getProductsData() throws -> Data {
        return try JSONEncoder().encode(getSuccessProducts())
    }
}
