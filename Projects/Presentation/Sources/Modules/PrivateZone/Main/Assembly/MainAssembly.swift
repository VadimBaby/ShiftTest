//
//  MainAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

final class MainAssembly {
    private init() {}
    
    static func create(
        router: MainPresenterOutput,
        resolver: Resolver
    ) -> UIViewController & MainViewInput {
        let view = MainView()
        let interactor = MainInteractor(
            getProductsUseCase: resolver.resolve(GetProductsUseCaseProtocol.self)!,
            getUserFullNameUseCase: resolver.resolve(GetUserFullNameUseCaseProtocol.self)!
        )
        let presenter = MainPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = router
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> MainRouterInput {
        let router = MainRouter(navigationController: navigationController, resolver: resolver)
        router.moduleAssembly = Self.create
        return router
    }
}

#if DEBUG
extension MainAssembly {
    static func createMock() -> UIViewController & MainViewInput {
        let view = MainView()
        let interactor = MainInteractor(
            getProductsUseCase: MockGetProductsUseCase(),
            getUserFullNameUseCase: MockGetUserFullNameUseCase()
        )
        let presenter = MainPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
