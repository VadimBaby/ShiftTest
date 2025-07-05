//
//  UserDefaultsDataSource.swift
//  DataSources
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Data
import MyCommon
import Domain

public final class UserDataSource: UserDataSourceProtocol {
    private let storage: UserWrappedDefaultsProtocol
    
    public init(storage: UserWrappedDefaultsProtocol) {
        self.storage = storage
    }
    
    public func getFullName() async throws -> String? {
        guard let user = storage.getUser() else { return nil }
        return user.getFullName()
    }
    
    public func setUser(_ user: User) async throws {
        storage.setUser(user)
        try await saveSession()
    }
    
    public func isAuthorize() async throws -> Bool {
        let sessionId = storage.getSessionID()
        return sessionId.isNotNil
    }
}

// MARK: - Private Methods

private extension UserDataSource {
    func saveSession() async throws {
        let sessionID = UUID()
        storage.setSessionID(sessionID)
   }
}
