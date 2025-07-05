//
//  ProductRepository.swift
//  Data
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

public final class ProductRepository: ProductRepositoryProtocol {
    private let networkDataSource: NetworkingDataSourceProtocol
    
    public init(networkDataSource: NetworkingDataSourceProtocol) {
        self.networkDataSource = networkDataSource
    }
    
    public func getProducts() async throws -> [Product] {
        return try await networkDataSource.getProducts()
    }
}
