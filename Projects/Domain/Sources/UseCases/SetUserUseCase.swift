//
//  SetUserNameUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol SetUserUseCaseProtocol: AnyObject {
    func execute(user: User) async throws
}

public final class SetUserUseCase: SetUserUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(user: User) async throws {
        try await repository.setUser(user)
    }
}

// MARK: - Mock

public final class MockSetUserUseCase: SetUserUseCaseProtocol {
    public init() {}
    
    private var user: User?
    
    public func execute(user: User) async throws {
        self.user = user
    }
}
