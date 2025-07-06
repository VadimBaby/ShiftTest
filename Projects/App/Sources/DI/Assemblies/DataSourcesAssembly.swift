//
//  DataSourcesAssembly.swift
//  ShiftTest
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Data
import DataSources
import Networking

final class DataSourcesAssembly: Assembly {
    func assemble(container: Registration) {
        container.register(UserWrappedDefaultsProtocol.self) { _ in
            UserWrappedDefaults()
        }
        
        container.register(UserDataSourceProtocol.self) { resolver in
            UserDataSource(storage: resolver.resolve(UserWrappedDefaultsProtocol.self)!)
        }
        
        container.register(NetworkingDataSourceProtocol.self) { resolver in
            NetworkingDataSource(networking: resolver.resolve(NetworkingProtocol.self)!)
        }
    }
}
