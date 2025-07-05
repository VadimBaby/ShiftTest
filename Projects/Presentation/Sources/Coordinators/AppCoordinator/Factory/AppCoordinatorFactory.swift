//
//  AppCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

public final class AppCoordinatorFactory {
    private init() {}
    
    public static func create(window: UIWindow, resolver: Resolver) -> AppCoordinatorInput {
        AppCoordinator(
            window: window,
            resolver: resolver,
            publicZoneFlowCoordinatorAssembly: PublicZoneFlowCoordinatorFactory.create,
            privateZoneCoordinatorAssembly: PrivateZoneFlowCoordinatorFactory.create
        )
    }
}
