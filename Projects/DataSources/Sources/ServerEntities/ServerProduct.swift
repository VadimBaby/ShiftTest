//
//  ServerProduct.swift
//  DataSources
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import MyCommon
import Domain

struct ServerProduct: Codable {
    let id: Int?
    let title: String?
    let price: Double?
}

extension ServerProduct {
    func toDomain() -> Product {
        Product(id: id.orZero, title: title.orEmpty, price: price.orZero)
    }
}
