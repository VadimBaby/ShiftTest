//
//  NetworkingDataSourceTests.swift
//  DataSourcesTests
//
//  Created by Вадим Мартыненко on 05.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import XCTest
// swiftlint:disable:next foundation_using
import Foundation
@testable import Domain
@testable import DataSources

final class NetworkingDataSourceTests: XCTestCase {
    func testSuccessProducts() async throws {
        // setup
        let networking = MockNetworking(configuration: .success)
        let networkingDataSource = NetworkingDataSource(networking: networking)
        
        // when
        let products = try await networkingDataSource.getProducts()
        
        // then
        XCTAssertTrue(networking.didCallFetch)
        
        let expectedProducts = networking.getSuccessProducts()
        
        checkEqual(products: products, expectedProducts: expectedProducts)
    }
    
    func testEmptyProducts() async throws {
        // setup
        let networking = MockNetworking(configuration: .empty)
        let networkingDataSource = NetworkingDataSource(networking: networking)
        
        do {
            _ = try await networkingDataSource.getProducts()
            XCTFail("networkingDataSource.getProducts() is completed success")
        } catch {
            XCTAssertTrue(networking.didCallFetch)
            XCTAssertTrue(true)
        }
    }
    
    func testWrongProducts() async throws {
        // setup
        let networking = MockNetworking(configuration: .wrongData)
        let networkingDataSource = NetworkingDataSource(networking: networking)
        
        do {
            _ = try await networkingDataSource.getProducts()
            XCTFail("networkingDataSource.getProducts() is completed success")
        } catch {
            XCTAssertTrue(networking.didCallFetch)
            XCTAssertTrue(true)
        }
    }
    
    func testLongDelayProducts() async throws {
        // setup
        let networking = MockNetworking(configuration: .longDelay)
        let networkingDataSource = NetworkingDataSource(networking: networking)
        
        // when
        let products = try await networkingDataSource.getProducts()
        
        // then
        XCTAssertTrue(networking.didCallFetch, "Expected networking fetch to be called")
        
        let expectedProducts = networking.getSuccessProducts()
        
        checkEqual(products: products, expectedProducts: expectedProducts)
    }
}

private extension NetworkingDataSourceTests {
    func checkEqual(products: [Product], expectedProducts: [ServerProduct]) {
        XCTAssertEqual(products.count, expectedProducts.count)
        
        for index in products.indices {
            let product = products[index]
            let expectedProduct = expectedProducts[index]
            
            XCTAssertEqual(product.id, expectedProduct.id)
            XCTAssertEqual(product.title, expectedProduct.title)
            XCTAssertEqual(product.price, expectedProduct.price)
        }
    }
}
