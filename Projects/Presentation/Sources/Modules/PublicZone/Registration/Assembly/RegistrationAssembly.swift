//
//  RegistrationAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import UIKit

final class RegistrationAssembly {
    private init() {}
    
    static func create(
        router: RegistrationPresenterOutput,
        resolver: Resolver
    ) -> UIViewController & RegistrationViewInput {
        let view = RegistrationView()
        let interactor = RegistrationInteractor(
            setUserUseCase: resolver.resolve(SetUserUseCaseProtocol.self)!,
            checkUserIsAuthorizeUseCase: resolver.resolve(CheckUserIsAuthorizeUseCaseProtocol.self)!
        )
        let presenter = RegistrationPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = router
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> RegistrationRouterInput {
        let router = RegistrationRouter(navigationController: navigationController, resolver: resolver)
        router.moduleAssembly = Self.create
        return router
    }
}

#if DEBUG
extension RegistrationAssembly {
    static func createMock() -> UIViewController & RegistrationViewInput {
        let view = RegistrationView()
        let interactor = RegistrationInteractor(
            setUserUseCase: MockSetUserUseCase(),
            checkUserIsAuthorizeUseCase: MockCheckUserIsAuthorizeUseCase()
        )
        let presenter = RegistrationPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
