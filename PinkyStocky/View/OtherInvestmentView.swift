//
//  OtherInvestmentView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/06.
//

import UIKit

final class OtherInvestmentView: UIView {

    let symbolName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    
    let priceChange: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        return label
    }()
    
    
    
    let currentPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.textColor = .headerPink
        return label
    }()
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(symbolName)
        self.addSubview(priceChange)
        self.addSubview(currentPrice)
        setupLayout()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        symbolName.translatesAutoresizingMaskIntoConstraints = false
        
        symbolName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        symbolName.topAnchor.constraint(equalTo: self.topAnchor, constant: 9).isActive = true


        currentPrice.translatesAutoresizingMaskIntoConstraints = false
        
        currentPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        currentPrice.centerYAnchor.constraint(equalTo: symbolName.centerYAnchor).isActive = true
        
        
        priceChange.translatesAutoresizingMaskIntoConstraints = false
        
        priceChange.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        priceChange.topAnchor.constraint(equalTo: symbolName.bottomAnchor, constant: 10).isActive = true
        priceChange.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        
        
        
    }
}
