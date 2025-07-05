//
//  UILabel.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import MyCommon

extension UILabel {
    static func label(text: String? = nil, font: AppFont) -> UILabel {
        UILabel() &> {
            $0.font = font.font()
            $0.text = text
        }
    }
}
