//
//  PublicZoneFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import MyCommon

protocol PublicZoneFlowCoordinatorOutput: AnyObject {
    func publicZoneDidFinish()
    func checkUserAuthorizeComeWithSuccess()
}

protocol PublicZoneFlowCoordinatorInput: NavigationCoordinator {
    var delegate: PublicZoneFlowCoordinatorOutput? { get set }
}

final class PublicZoneFlowCoordinator: PublicZoneFlowCoordinatorInput {
    var navigationController: UINavigationController
    weak var delegate: PublicZoneFlowCoordinatorOutput?
    
    typealias RegistrationRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> RegistrationRouterInput
    
    private let window: UIWindow
    private let resolver: Resolver
    
    private let registrationRouterAssembly: RegistrationRouterAssembly
    private var registrationRouter: RegistrationRouterInput?
    
    init(
        window: UIWindow,
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        registrationRouterAssembly: @escaping RegistrationRouterAssembly
    ) {
        self.window = window
        self.resolver = resolver
        self.navigationController = navigationController
        self.registrationRouterAssembly = registrationRouterAssembly
    }
    
    func start() {
        openRegistrationScreen()
        window.rootViewController = navigationController
    }
}

// MARK: - Private Methods

private extension PublicZoneFlowCoordinator {
    func openRegistrationScreen() {
        if registrationRouter.isNil {
            registrationRouter = registrationRouterAssembly(navigationController, resolver)
            registrationRouter?.delegate = self
        }
        
        registrationRouter?.open()
    }
}

// MARK: - RegistrationRouterOutput

extension PublicZoneFlowCoordinator: RegistrationRouterOutput {
    func registrationDidFinish() {
        delegate?.publicZoneDidFinish()
    }
    
    func checkUserAuthorizeComeWithSuccess() {
        delegate?.checkUserAuthorizeComeWithSuccess()
    }
}
