//
//  Product.swift
//  Domain
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public struct Product {
    public let id: Int
    public let title: String
    public let price: Double
    
    public init(id: Int, title: String, price: Double) {
        self.id = id
        self.title = title
        self.price = price
    }
}

// MARK: - Mock

extension Product {
    static let mock = Product(id: 1, title: "Mock", price: 123)
}
