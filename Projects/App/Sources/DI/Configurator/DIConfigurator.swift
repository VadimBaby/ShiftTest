//
//  DIConfigurator.swift
//  ShiftTest
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Presentation

protocol Assembly: AnyObject {
    func assemble(container: Registration)
}

final class DIConfigurator {
    static func configure(with assemblies: [Assembly]) -> Resolver {
        let container = DIContainer(defaultObjectScope: .container)
        
        for assembly in assemblies {
            assembly.assemble(container: container)
        }
        
        return container
    }
}
