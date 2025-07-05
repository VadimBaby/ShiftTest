//
//  AppDelegate.swift
//  ShiftTest
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Presentation

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinatorInput?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let resolver = DIConfigurator.configure(
            with: [NetworkingAssembly(), DataSourcesAssembly(), DataAssembly(), DomainAssembly()]
        )
        
        appCoordinator = AppCoordinatorFactory.create(window: window!, resolver: resolver)
        appCoordinator?.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}
