//
//  FinancialLiveTradeCell.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/04.
//

import UIKit

final class FinancialLiveTradeCell: UICollectionViewCell {
    
    static let identifier = "FinancialLiveTradeCell"
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    let priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    let changePercentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(nameLabel)
        self.addSubview(priceLabel)
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
    }
    
    
    
    
}
