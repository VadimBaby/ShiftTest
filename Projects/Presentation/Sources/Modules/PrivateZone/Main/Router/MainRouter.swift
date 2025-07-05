//
//  MainRouter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol MainRouterOutput: AnyObject {
    
}

protocol MainRouterInput: Router {
    var delegate: MainRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: MainPresenterOutput, _ resolver: Resolver) -> UIViewController & MainViewInput
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class MainRouter: MainRouterInput {
    weak var delegate: MainRouterOutput?
    
    private let resolver: Resolver
    
    var navigationController: UINavigationController
    
    var moduleAssembly: ModuleAssembly?
    
    init(
        navigationController: UINavigationController,
        resolver: Resolver
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
    }
    
    func open() {
        guard let module = moduleAssembly?(self, resolver) else { fatalError("moduleAssembly is nil in \(self)") }
        navigationController.pushViewController(module, animated: true)
    }
}

extension MainRouter: MainPresenterOutput {
    
}
