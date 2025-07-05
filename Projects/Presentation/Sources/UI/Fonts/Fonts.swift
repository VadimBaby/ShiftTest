//
//  Fonts.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

enum AppFont {
    case title, description, buttonTitle, headline
    
    func font() -> UIFont {
        switch self {
        case .title:
            return .systemFont(ofSize: 24, weight: .bold)
        case .description:
            return .systemFont(ofSize: 20, weight: .regular)
        case .buttonTitle:
            return .systemFont(ofSize: 20, weight: .medium)
        case .headline:
            return .preferredFont(forTextStyle: .headline)
        }
    }
}

extension UIFont {
    static func font(_ font: AppFont) -> UIFont {
        font.font()
    }
}
