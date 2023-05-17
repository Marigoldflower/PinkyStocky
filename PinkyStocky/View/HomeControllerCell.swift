//
//  HomeControllerCell.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/15.
//

import UIKit
import Charts

final class HomeControllerCell: UITableViewCell {
    
    
    lazy var codeName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    /// Company Label
    lazy var detailName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.5, weight: .regular)
        return label
    }()
    
    /// Price Label
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    /// Change Label
    lazy var changeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        return label
    }()
    
    
    lazy var stockChartsView: StockChartsView = {
        let newView = StockChartsView()
        return newView
    }()
    
    
    // MARK: - 스택 뷰
    
    
    lazy var companyStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [codeName, detailName])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    
    
    //    lazy var priceStackView: UIStackView = {
    //        let stack = UIStackView(arrangedSubviews: [priceLabel, changeLabel])
    //        stack.axis = .vertical
    //        stack.distribution = .fill
    //        stack.spacing = 5
    //        return stack
    //    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(companyStackView)
        self.addSubview(priceLabel)
        self.addSubview(changeLabel)
        self.addSubview(stockChartsView)
        setupLayout()
//        setupTableViewCellSize()
      
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupLayout() {
        companyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        companyStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        companyStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        detailName.translatesAutoresizingMaskIntoConstraints = false
        
        detailName.widthAnchor.constraint(equalToConstant: 175).isActive = true
        
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: companyStackView.topAnchor).isActive = true
        
        
        
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        changeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true
        changeLabel.widthAnchor.constraint(equalToConstant: 43).isActive = true
        
        
        stockChartsView.translatesAutoresizingMaskIntoConstraints = false
        stockChartsView.trailingAnchor.constraint(equalTo: changeLabel.leadingAnchor, constant: -8).isActive = true
        stockChartsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stockChartsView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        stockChartsView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
    }
    
    

    
}
