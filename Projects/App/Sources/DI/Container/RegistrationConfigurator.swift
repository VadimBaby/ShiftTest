//
//  RegistrationConfigurator.swift
//  ShiftTest
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

final class RegistrationConfigurator {
    weak var container: DIContainer?
    var type: Any.Type
    var name: String?

    init(_ container: DIContainer, _ type: Any.Type, _ name: String? = nil) {
        self.container = container
        self.type = type
        self.name = name
    }

    func inObjectScope(_ scope: ContainerObjectScope) {
        container?.register(type: type, name: name, in: scope)
    }
    
    func implements(_ types: Any.Type...) {
        container?.implements(type: type, types: types)
    }
}
