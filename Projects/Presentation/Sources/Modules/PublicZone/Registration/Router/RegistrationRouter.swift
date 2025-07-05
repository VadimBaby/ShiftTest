//
//  RegistrationRouter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol RegistrationRouterOutput: AnyObject {
    func registrationDidFinish()
    func checkUserAuthorizeComeWithSuccess()
}

protocol RegistrationRouterInput: Router {
    var delegate: RegistrationRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: RegistrationPresenterOutput, _ resolver: Resolver) -> UIViewController & RegistrationViewInput
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class RegistrationRouter: RegistrationRouterInput {
    weak var delegate: RegistrationRouterOutput?
    
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

extension RegistrationRouter: RegistrationPresenterOutput {
    func registrationDidEnd() {
        delegate?.registrationDidFinish()
    }
    
    func checkUserAuthorizeComeWithSuccess() {
        delegate?.checkUserAuthorizeComeWithSuccess()
    }
}
