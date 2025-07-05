//
//  PrivateZoneFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import MyCommon
import UIKit

protocol PrivateZoneFlowCoordinatorInput: NavigationCoordinator {
    func start(animated: Bool)
}

final class PrivateZoneFlowCoordinator: PrivateZoneFlowCoordinatorInput {
    var navigationController: UINavigationController
    
    typealias MainRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> MainRouterInput
    
    private let window: UIWindow
    private let resolver: Resolver
    
    private let mainRouterAssembly: MainRouterAssembly
    private var mainRouter: MainRouterInput?
    
    init(
        window: UIWindow,
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        mainRouterAssembly: @escaping MainRouterAssembly
    ) {
        self.window = window
        self.resolver = resolver
        self.navigationController = navigationController
        self.mainRouterAssembly = mainRouterAssembly
    }
    
    func start() {
        start(animated: false)
    }
    
    func start(animated: Bool) {
        openMainScreen()
        window.setRootViewController(navigationController, animated: animated)
    }
}

// MARK: - Private Methods

private extension PrivateZoneFlowCoordinator {
    func openMainScreen() {
        if mainRouter.isNil {
            mainRouter = mainRouterAssembly(navigationController, resolver)
            mainRouter?.delegate = self
        }
        
        mainRouter?.open()
    }
}

// MARK: - MainRouterOutput

extension PrivateZoneFlowCoordinator: MainRouterOutput {
    
}
