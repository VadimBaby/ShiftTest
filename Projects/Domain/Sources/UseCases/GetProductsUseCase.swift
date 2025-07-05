//
//  GetProductsUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol GetProductsUseCaseProtocol: AnyObject {
    func execute() async throws -> [Product]
}

public final class GetProductsUseCase: GetProductsUseCaseProtocol {
    private let repository: ProductRepositoryProtocol
    
    public init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() async throws -> [Product] {
        return try await repository.getProducts()
    }
}

// MARK: - Mock

public final class MockGetProductsUseCase: GetProductsUseCaseProtocol {
    public init() {}
    
    public func execute() async throws -> [Product] {
        return [.mock]
    }
}
