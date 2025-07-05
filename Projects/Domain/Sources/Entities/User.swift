//
//  User.swift
//  Domain
//
//  Created by Вадим Мартыненко on 05.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public struct User: Codable {
    public let id: UUID
    public let name: String
    public let surname: String
    public let birthdate: Date
    
    public init(name: String, surname: String, birthdate: Date) {
        self.id = .init()
        self.name = name
        self.surname = surname
        self.birthdate = birthdate
    }
    
    public func getFullName() -> String {
        surname + .space + name
    }
}
