//
//  PrivateZoneFlowCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class PrivateZoneFlowCoordinatorFactory {
    private init() {}
    
    static func create(window: UIWindow, resolver: Resolver) -> PrivateZoneFlowCoordinatorInput {
        PrivateZoneFlowCoordinator(
            window: window,
            resolver: resolver,
            mainRouterAssembly: MainAssembly.router
        )
    }
}
