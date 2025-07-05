//
//  UIKit+Preview.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import SwiftUI
import UIKit

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
    
    func asPreview() -> some View {
        Preview(viewController: self).ignoresSafeArea()
    }
}

extension UIView {
    private struct Preview: UIViewRepresentable {
        let uiView: UIView
        
        func makeUIView(context: Context) -> UIView {
            uiView
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
    }
    
    func asPreview() -> some View {
        Preview(uiView: self)
    }
}
