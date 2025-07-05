//
//  Resolver.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.

public protocol Resolver: AnyObject {
    func resolve<T>(_ type: T.Type, name: String?) -> T?
}

public extension Resolver {
    func resolve<T>(_ type: T.Type, name: String? = nil) -> T? {
        resolve(type, name: name)
    }
}
