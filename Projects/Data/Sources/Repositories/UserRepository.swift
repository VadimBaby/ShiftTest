//
//  SettingsRepository.swift
//  Data
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

public final class UserRepository: UserRepositoryProtocol {
    private let localDataSource: UserDataSourceProtocol
    
    public init(localDataSource: UserDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    public func getFullName() async throws -> String? {
        return try await localDataSource.getFullName()
    }
    
    public func setUser(_ user: User) async throws {
        try await localDataSource.setUser(user)
    }
    
    public func isAuthorize() async throws -> Bool {
        try await localDataSource.isAuthorize()
    }
}
