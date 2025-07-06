//
//  DomainAssembly.swift
//  ShiftTest
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

final class DomainAssembly: Assembly {
    func assemble(container: Registration) {
        container.register(GetUserFullNameUseCaseProtocol.self) { resolver in
            GetUserFullNameUseCase(repository: resolver.resolve(UserRepositoryProtocol.self)!)
        }
        
        container.register(SetUserUseCaseProtocol.self) { resolver in
            SetUserUseCase(repository: resolver.resolve(UserRepositoryProtocol.self)!)
        }
        
        container.register(GetProductsUseCaseProtocol.self) { resolver in
            GetProductsUseCase(repository: resolver.resolve(ProductRepositoryProtocol.self)!)
        }
        
        container.register(CheckUserIsAuthorizeUseCaseProtocol.self) { resolver in
            CheckUserIsAuthorizeUseCase(repository: resolver.resolve(UserRepositoryProtocol.self)!)
        }
    }
}
