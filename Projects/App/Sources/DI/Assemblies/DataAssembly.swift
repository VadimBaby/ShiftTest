//
//  DataAssembly.swift
//  ShiftTest
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import Data

final class DataAssembly: Assembly {
    func assemble(container: Registration) {
        container.register(UserRepositoryProtocol.self) { resolver in
            UserRepository(localDataSource: resolver.resolve(UserDataSourceProtocol.self)!)
        }
        
        container.register(ProductRepositoryProtocol.self) { resolver in
            ProductRepository(networkDataSource: resolver.resolve(NetworkingDataSourceProtocol.self)!)
        }
    }
}
