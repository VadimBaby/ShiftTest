//
//  PublicZoneFlowCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class PublicZoneFlowCoordinatorFactory {
    private init() {}
    
    static func create(window: UIWindow, resolver: Resolver) -> PublicZoneFlowCoordinatorInput {
        PublicZoneFlowCoordinator(
            window: window,
            resolver: resolver,
            registrationRouterAssembly: RegistrationAssembly.router
        )
    }
}
