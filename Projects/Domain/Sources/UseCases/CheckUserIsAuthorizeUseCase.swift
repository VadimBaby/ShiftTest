//
//  CheckUserIsAuthorizeUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 05.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol CheckUserIsAuthorizeUseCaseProtocol: AnyObject {
    func execute() async throws -> Bool
}

public final class CheckUserIsAuthorizeUseCase: CheckUserIsAuthorizeUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() async throws -> Bool {
        return try await repository.isAuthorize()
    }
}

// MARK: - Mock

public final class MockCheckUserIsAuthorizeUseCase: CheckUserIsAuthorizeUseCaseProtocol {
    public init() {}
    
    public func execute() async throws -> Bool {
        return false
    }
}
