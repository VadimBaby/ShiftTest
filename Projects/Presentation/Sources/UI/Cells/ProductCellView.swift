//
//  ProductCellView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 04.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import UIKit
import MyCommon
import SnapKit

final class ProductCellView: UITableViewCell {
    static let reuseID = "\(ProductCellView.self)"
    
    private lazy var titleLabel: UILabel = .label(font: .headline) &> {
        $0.numberOfLines = 0
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    private lazy var priceLabel: UILabel = .label(font: .description) &> {
        $0.numberOfLines = 1
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = NumbersFormatter.formatWithMinimalDecimals(product.price) + .rubleSign
    }
}

// MARK: - Views

private extension ProductCellView {
    func addViews() {
        contentView.addSubviews(titleLabel, priceLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(AppConstants.Padding.default)
            make.top.equalToSuperview().offset(AppConstants.Padding.small)
            make.bottom.equalToSuperview().inset(AppConstants.Padding.small)
            make.trailing.equalTo(priceLabel.snp.leading).offset(-AppConstants.Padding.small)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppConstants.Padding.default)
            make.top.equalToSuperview().offset(AppConstants.Padding.small)
            make.bottom.equalToSuperview().inset(AppConstants.Padding.small)
        }
    }
}
