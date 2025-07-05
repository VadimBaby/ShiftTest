//
//  GetUserNameUserCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol GetUserFullNameUseCaseProtocol: AnyObject {
    func execute() async throws -> String?
}

public final class GetUserFullNameUseCase: GetUserFullNameUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() async throws -> String? {
        try await repository.getFullName()
    }
}

// MARK: - Mock

public final class MockGetUserFullNameUseCase: GetUserFullNameUseCaseProtocol {
    public init() {}
    
    private let user = User(name: "Иван", surname: "Иванов", birthdate: .now)
    
    public func execute() async throws -> String? {
        return user.getFullName()
    }
}
