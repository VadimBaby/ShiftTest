//
//  UIButton.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

extension UIButton {
    static func primary(title: String, backgroundColor: UIColor = .blue) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = backgroundColor
        configuration.baseForegroundColor = .white
        configuration.background.cornerRadius = 15
        configuration.attributedTitle = AttributedString(title, attributes: AttributeContainer([.font: UIFont.font(.buttonTitle)]))
        
        return UIButton(configuration: configuration)
    }
}
