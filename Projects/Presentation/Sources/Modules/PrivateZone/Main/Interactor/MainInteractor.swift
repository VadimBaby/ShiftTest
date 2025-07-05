//
//  MainInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

protocol MainInteractorOutput: AnyObject {
    func productsDidFetch(_ products: [Product])
    func nameDidFetch(_ name: String)
}

protocol MainInteractorInput: AnyObject {
    var output: MainInteractorOutput? { get set }
    
    func viewDidLoad()
    func helloButtonDidPress()
}

final class MainInteractor: MainInteractorInput {
    weak var output: MainInteractorOutput?
    
    private let getProductsUseCase: GetProductsUseCaseProtocol
    private let getUserFullNameUseCase: GetUserFullNameUseCaseProtocol
    
    public init(
        getProductsUseCase: GetProductsUseCaseProtocol,
        getUserFullNameUseCase: GetUserFullNameUseCaseProtocol
    ) {
        self.getProductsUseCase = getProductsUseCase
        self.getUserFullNameUseCase = getUserFullNameUseCase
    }
    
    private enum MainInteractorError: Error {
        case nameIsNil
    }
    
    func viewDidLoad() {
        Task {
            do {
                let products = try await getProductsUseCase.execute()
                await MainActor.run {
                    output?.productsDidFetch(products)
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func helloButtonDidPress() {
        Task {
            do {
                guard let name = try await getUserFullNameUseCase.execute() else { throw MainInteractorError.nameIsNil }
                await MainActor.run {
                    output?.nameDidFetch(name)
                }
            } catch {
                debugPrint(error)
            }
        }
    }
}
