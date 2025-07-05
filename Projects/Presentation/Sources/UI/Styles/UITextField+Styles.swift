//
//  UITextField+Styles.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import MyCommon
import UIKit

extension UITextField {
    static func primary(placeholder: String, backgroundColor: UIColor = .secondarySystemBackground) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = backgroundColor
        textField.layer.cornerRadius = 15
        
        let leftView = UIView() &> {
            $0.frame.size = .init(width: 20, height: 1)
        }
        
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        return textField
    }
    
    static func securePrimary(placeholder: String, backgroundColor: UIColor = .secondarySystemBackground) -> UITextField {
        primary(placeholder: placeholder, backgroundColor: backgroundColor) &> {
            $0.isSecureTextEntry = true
        }
    }
}
