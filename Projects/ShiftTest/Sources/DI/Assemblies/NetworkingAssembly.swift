//
//  NetworkingAssembly.swift
//  ShiftTest
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Networking

final class NetworkingAssembly: Assembly {
    func assemble(container: Registration) {
        container.register(NetworkingProtocol.self) { _ in
            Networking()
        }
    }
}
