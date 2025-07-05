//
//  NetworkingDataSourceProtocol.swift
//  Data
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

public protocol NetworkingDataSourceProtocol: AnyObject {
    func getProducts() async throws -> [Product]
}
