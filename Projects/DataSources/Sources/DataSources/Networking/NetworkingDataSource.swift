//
//  NetworkingDataSource.swift
//  DataSources
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Networking
import Domain
import Data

public final class NetworkingDataSource: NetworkingDataSourceProtocol {
    private let networking: NetworkingProtocol
    
    public init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    private enum Routing: Router {
        case products
        
        var baseURL: String {
            "https://fakestoreapi.com"
        }
        
        var endpoint: String {
            switch self {
            case .products: "products"
            }
        }
        
        var method: HTTPMethod {
            .get
        }
    }
    
    public func getProducts() async throws -> [Product] {
        let serverResult = try await networking.fetch(returnType: [ServerProduct].self, router: Routing.products)
        let result = serverResult.map{ $0.toDomain() }
        return result
    }
}
