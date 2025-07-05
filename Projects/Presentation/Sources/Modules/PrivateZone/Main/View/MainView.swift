//
//  MainView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain
import MyCommon
import SnapKit

protocol MainViewOutput: AnyObject {
    func viewDidLoad()
    func helloButtonDidPress()
}

protocol MainViewInput: AnyObject {
    var output: MainViewOutput? { get set }
    
    func setProducts(_ products: [Product])
    func showHelloAlertWithName(_ name: String)
}

final class MainView: UIViewController, MainViewInput {
    var output: MainViewOutput?
    
    private lazy var tableView = UITableView(frame: view.bounds) &> {
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UITableView.automaticDimension
        $0.register(ProductCellView.self, forCellReuseIdentifier: ProductCellView.reuseID)
    }
    
    private lazy var activityIndicatorView = UIActivityIndicatorView() &> {
        $0.hidesWhenStopped = true
    }
    
    private lazy var helloButton: UIButton = .primary(title: Strings.Main.Button.hello) &> {
        $0.addTarget(self, action: #selector(helloButtonPressed), for: .touchUpInside)
    }
    
    private var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        setupRootView()
        addSubviews()
        setupConsraints()
        hideMainContentAndStartAnimatingActivityIndicator()
    }
    
    func setProducts(_ products: [Product]) {
        self.products = products
        tableView.reloadData()
        showMainContentAndStopAnimatingActivityIndicator()
    }
    
    func showHelloAlertWithName(_ name: String) {
        let alertVC = UIAlertController(
            title: Strings.Main.Alert.Hello.title,
            message: "\(Strings.Main.Alert.Hello.description) \(name)",
            preferredStyle: .alert
        )
        alertVC.addAction(.init(title: Strings.Main.Alert.Hello.ok, style: .default))
        present(alertVC, animated: true)
    }
}

// MARK: - Private Methods

private extension MainView {
    @objc
    func helloButtonPressed() {
        output?.helloButtonDidPress()
    }
}

// MARK: - Subviews

private extension MainView {
    func setupRootView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = Strings.Main.systemTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addSubviews() {
        view.addSubviews(tableView, activityIndicatorView)
        view.insertSubview(helloButton, aboveSubview: tableView)
    }
    
    func setupConsraints() {
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(AppConstants.ActivityIndicator.size)
        }
        
        helloButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppConstants.Padding.default)
            make.bottom.equalToSuperview().inset(AppConstants.Padding.default)
            make.height.equalTo(AppConstants.Button.height)
        }
    }
    
    func hideMainContentAndStartAnimatingActivityIndicator() {
        tableView.isHidden = true
        helloButton.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    func showMainContentAndStopAnimatingActivityIndicator() {
        activityIndicatorView.stopAnimating()
        tableView.isHidden = false
        helloButton.isHidden = false
    }
}

// MARK: - UITableViewDataSource

extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCellView.reuseID, for: indexPath) as? ProductCellView else {
            fatalError("Cant cast cell")
        }
        let product = products[indexPath.row]
        cell.setup(with: product)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - Preview

#if DEBUG && canImport(SwiftUI)
import SwiftUI
struct MainViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: MainAssembly.createMock()
        ).asPreview()
    }
}
#endif
