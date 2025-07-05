//
//  MainPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

protocol MainPresenterOutput: AnyObject {
    
}

protocol MainPresenterInput: AnyObject {
    var output: MainPresenterOutput? { get set }
}

final class MainPresenter: MainPresenterInput {
    weak var output: MainPresenterOutput?
    
    private unowned let view: MainViewInput
    private let interactor: MainInteractorInput
    
    init(view: MainViewInput, interactor: MainInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func helloButtonDidPress() {
        interactor.helloButtonDidPress()
    }
}

// MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {
    func productsDidFetch(_ products: [Product]) {
        view.setProducts(products)
    }
    
    func nameDidFetch(_ name: String) {
        view.showHelloAlertWithName(name)
    }
}
