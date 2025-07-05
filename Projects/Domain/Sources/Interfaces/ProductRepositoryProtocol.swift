//
//  ProductRepositoryProtocol.swift
//  Domain
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol ProductRepositoryProtocol: AnyObject {
    func getProducts() async throws -> [Product]
}
