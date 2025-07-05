//
//  SettingsRepositoryProtocol.swift
//  Domain
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol UserRepositoryProtocol: AnyObject {
    func getFullName() async throws -> String?
    func setUser(_ user: User) async throws
    func isAuthorize() async throws -> Bool
}
