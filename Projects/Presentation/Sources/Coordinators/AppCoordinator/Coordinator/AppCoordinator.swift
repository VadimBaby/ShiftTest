//
//  AppCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import UIKit
import MyCommon

public protocol AppCoordinatorInput: Coordinator { }

public final class AppCoordinator: AppCoordinatorInput {
    private let window: UIWindow
    private let resolver: Resolver
    
    typealias PublicZoneFlowCoordinatorAssembly = (_ window: UIWindow, _ resolver: Resolver) -> PublicZoneFlowCoordinatorInput
    typealias PrivateZoneCoordinatorAssembly = (_ window: UIWindow, _ resolver: Resolver) -> PrivateZoneFlowCoordinatorInput
    
    private let publicZoneFlowCoordinatorAssembly: PublicZoneFlowCoordinatorAssembly
    private let privateZoneCoordinatorAssembly: PrivateZoneCoordinatorAssembly
    
    private var publicZoneFlowCoordinator: PublicZoneFlowCoordinatorInput?
    private var privateZoneFlowCoordinator: PrivateZoneFlowCoordinatorInput?
    
    init(
        window: UIWindow,
        resolver: Resolver,
        publicZoneFlowCoordinatorAssembly: @escaping PublicZoneFlowCoordinatorAssembly,
        privateZoneCoordinatorAssembly: @escaping PrivateZoneCoordinatorAssembly
    ) {
        self.window = window
        self.resolver = resolver
        self.publicZoneFlowCoordinatorAssembly = publicZoneFlowCoordinatorAssembly
        self.privateZoneCoordinatorAssembly = privateZoneCoordinatorAssembly
    }
    
    public func start() {
         showPublicZone()
    }
}

// MARK: - Private Methods

private extension AppCoordinator {
    func showPrivateZone(animated: Bool) {
        if privateZoneFlowCoordinator.isNil {
            privateZoneFlowCoordinator = privateZoneCoordinatorAssembly(window, resolver)
        }
        
        privateZoneFlowCoordinator?.start(animated: animated)
    }
    
    func showPublicZone() {
        if publicZoneFlowCoordinator.isNil {
            publicZoneFlowCoordinator = publicZoneFlowCoordinatorAssembly(window, resolver)
            publicZoneFlowCoordinator?.delegate = self
        }
        
        publicZoneFlowCoordinator?.start()
    }
}

extension AppCoordinator: PublicZoneFlowCoordinatorOutput {
    func publicZoneDidFinish() {
        showPrivateZone(animated: true)
        publicZoneFlowCoordinator = nil
    }
    
    func checkUserAuthorizeComeWithSuccess() {
        showPrivateZone(animated: false)
        publicZoneFlowCoordinator = nil
    }
}
