//
//  String.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

extension String {
    func isValidPassword() -> Bool {
        contains(where: { $0.isNumber }) && contains(where: { $0.isUppercase })
    }
}
