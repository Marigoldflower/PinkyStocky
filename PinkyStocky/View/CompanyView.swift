//
//  LiveTradesCell.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/03.
//

import UIKit



final class CompanyView: UIView {
    
    
    // MARK: - Company Image
    
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 45 / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    
    // MARK: - Company Name
    
    let symbolName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "AAPL"
        return label
    }()
    
    
    
    let descriptionName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.5, weight: .regular)
        label.text = "Apple Inc."
        return label
    }()
    
    
    
    lazy var nameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [symbolName, descriptionName])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    
    
    
    // MARK: - Price
    
    let lastPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    
    
    let priceChangedPercentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        return label
    }()
    
    
    
    lazy var priceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lastPrice, priceChangedPercentageLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        self.addSubview(companyImageView)
        self.addSubview(nameStackView)
        self.addSubview(priceStackView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        nameStackView.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 10).isActive = true
        nameStackView.topAnchor.constraint(equalTo: companyImageView.topAnchor, constant: 5).isActive = true
        
        
        
        
        companyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        companyImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        companyImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        
        lastPrice.translatesAutoresizingMaskIntoConstraints = false
        
        lastPrice.centerXAnchor.constraint(equalTo: priceStackView.centerXAnchor).isActive = true
        
        
        
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        priceStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        priceStackView.topAnchor.constraint(equalTo: companyImageView.topAnchor, constant: 5).isActive = true
        
        
        
        priceChangedPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceChangedPercentageLabel.widthAnchor.constraint(equalToConstant: 43).isActive = true
    }
}
