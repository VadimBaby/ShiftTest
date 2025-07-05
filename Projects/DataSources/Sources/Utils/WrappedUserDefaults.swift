//
//  WrappedUserDefaults.swift
//  DataSources
//
//  Created by Вадим Мартыненко on 05.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation

protocol UserDefaultsKey {
    var key: String { get }
}

final class WrappedUserDefaults<Key: UserDefaultsKey> {
    private let userDefaults = UserDefaults.standard
    
    func set(_ value: Any?, forKey key: Key) {
        userDefaults.set(value, forKey: key.key)
    }
    
    func string(forKey key: Key) -> String? {
        return userDefaults.string(forKey: key.key)
    }
    
    func setObject<T: Encodable>(_ value: T, forKey key: Key) {
        if let data = try? JSONEncoder().encode(value) {
            userDefaults.set(data, forKey: key.key)
        }
    }
    
    func getObject<T: Decodable>(forKey key: Key, object: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key.key),
              let object = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return object
    }
}
