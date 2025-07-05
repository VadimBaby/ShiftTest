//
//  UserWrappedDefaults.swift
//  DataSources
//
//  Created by Вадим Мартыненко on 05.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain

public protocol UserWrappedDefaultsProtocol: AnyObject {
    func getUser() -> User?
    func setUser(_ user: User)
    func setSessionID(_ session: UUID)
    func getSessionID() -> UUID?
}

public class UserWrappedDefaults: UserWrappedDefaultsProtocol {
    private let storage = WrappedUserDefaults<Key>()
    
    public init() {}
    
    private enum Key: String, UserDefaultsKey {
        case user, sessionID
        
        var key: String { rawValue }
    }
    
    public func getUser() -> User? {
        storage.getObject(forKey: .user, object: User.self)
    }
    
    public func setUser(_ user: User) {
        storage.setObject(user, forKey: .user)
    }
    
    public func setSessionID(_ session: UUID) {
        storage.set(session.uuidString, forKey: .sessionID)
    }
    
    public func getSessionID() -> UUID? {
        guard let string = storage.string(forKey: .sessionID) else { return nil }
        return UUID(uuidString: string)
    }
}
