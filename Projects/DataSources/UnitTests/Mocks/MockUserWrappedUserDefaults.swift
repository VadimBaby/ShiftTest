//
//  MockUserWrappedUserDefaults.swift
//  DataSourcesTests
//
//  Created by Вадим Мартыненко on 05.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

@testable import DataSources
@testable import Domain
// swiftlint:disable:next foundation_using
import Foundation

final class MockUserWrappedUserDefaults: UserWrappedDefaultsProtocol {
    private(set) var getUserDidCall = false
    private(set) var setUserDidCall = false
    private(set) var setSessionIDDidCall = false
    private(set) var getSessionIDDidCall = false
    
    private let configuration: Configuration
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    enum Configuration {
        case `nil`, success
    }
    
    func getUser() -> User? {
        getUserDidCall = true
        
        return switch configuration {
        case .nil: nil
        case .success: mockUser()
        }
    }
    
    func setUser(_ user: User) {
        setUserDidCall = true
    }
    
    func setSessionID(_ session: UUID) {
        setSessionIDDidCall = true
    }
    
    func getSessionID() -> UUID? {
        getSessionIDDidCall = true
        
        return switch configuration {
        case .nil: nil
        case .success: .init()
        }
    }
}

extension MockUserWrappedUserDefaults {
    func mockUser() -> User {
        User(name: "Иван", surname: "Иванов", birthdate: .now)
    }
}
