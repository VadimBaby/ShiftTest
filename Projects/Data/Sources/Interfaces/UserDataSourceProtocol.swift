//
//  UserDefaultsDataSourceProtocol.swift
//  Data
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

public protocol UserDataSourceProtocol: AnyObject {
    func getFullName() async throws -> String?
    func setUser(_ user: User) async throws
    func isAuthorize() async throws -> Bool
}
