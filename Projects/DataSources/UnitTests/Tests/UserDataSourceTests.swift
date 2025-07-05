//
//  UserDataSourceTests.swift
//  DataSourcesTests
//
//  Created by Вадим Мартыненко on 05.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import XCTest
@testable import DataSources

final class UserDataSourceTests: XCTestCase {
    func testSuccessGetFullName() async throws {
        // setup
        let userWrappedUserDefaults = MockUserWrappedUserDefaults(configuration: .success)
        let userDataSource = UserDataSource(storage: userWrappedUserDefaults)
        
        // when
        guard let fullName = try await userDataSource.getFullName() else { XCTFail("fullname is nil"); return }
        
        // then
        XCTAssertTrue(userWrappedUserDefaults.getUserDidCall)
        
        let mockUser = userWrappedUserDefaults.mockUser()
        
        XCTAssertEqual(fullName, mockUser.getFullName())
    }
    
    func testFailureGetFullName() async throws {
        // setup
        let userWrappedUserDefaults = MockUserWrappedUserDefaults(configuration: .nil)
        let userDataSource = UserDataSource(storage: userWrappedUserDefaults)
        
        // when
        let fullName = try await userDataSource.getFullName()
        
        // then
        XCTAssertTrue(userWrappedUserDefaults.getUserDidCall)
        XCTAssertNil(fullName)
    }
    
    func testSuccessSetUser() async throws {
        // setup
        let userWrappedUserDefaults = MockUserWrappedUserDefaults(configuration: .success)
        let userDataSource = UserDataSource(storage: userWrappedUserDefaults)
        
        let user = userWrappedUserDefaults.mockUser()
        
        // when
        try await userDataSource.setUser(user)
        
        // then
        XCTAssertTrue(userWrappedUserDefaults.setUserDidCall)
        XCTAssertTrue(userWrappedUserDefaults.setSessionIDDidCall)
    }
    
    func testFailureSetUser() async throws {
        // setup
        let userWrappedUserDefaults = MockUserWrappedUserDefaults(configuration: .nil)
        let userDataSource = UserDataSource(storage: userWrappedUserDefaults)
        
        let user = userWrappedUserDefaults.mockUser()
        
        // when
        try await userDataSource.setUser(user)
        
        // then
        XCTAssertTrue(userWrappedUserDefaults.setUserDidCall)
        XCTAssertTrue(userWrappedUserDefaults.setSessionIDDidCall)
    }
    
    func testSuccessIsAuthorize() async throws {
        // setup
        let userWrappedUserDefaults = MockUserWrappedUserDefaults(configuration: .success)
        let userDataSource = UserDataSource(storage: userWrappedUserDefaults)
        
        // when
        let isAuthorize = try await userDataSource.isAuthorize()
        
        // then
        XCTAssertTrue(userWrappedUserDefaults.getSessionIDDidCall)
        XCTAssertTrue(isAuthorize)
    }
    
    func testFailureIsAuthorize() async throws {
        // setup
        let userWrappedUserDefaults = MockUserWrappedUserDefaults(configuration: .nil)
        let userDataSource = UserDataSource(storage: userWrappedUserDefaults)
        
        // when
        let isAuthorize = try await userDataSource.isAuthorize()
        
        // then
        XCTAssertTrue(userWrappedUserDefaults.getSessionIDDidCall)
        XCTAssertFalse(isAuthorize)
    }
}
