//
//  LiveTradesCell.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/03.
//

import UIKit
import Charts


class CompanyView: UIView {
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    
    let symbolName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "AAPL"
        return label
    }()
    
    
    
    let descriptionName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Apple Inc."
        return label
    }()
    
    
    
    let lastPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    
    
    let priceChangedPercentageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    
    
    let chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(true) // true
        chartView.xAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.legend.enabled = true // true
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = true // true
        
        return chartView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        self.addSubview(symbolName)
        self.addSubview(companyImageView)
        self.addSubview(lastPrice)
        self.addSubview(priceChangedPercentageLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout() {
        
        companyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        companyImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        symbolName.translatesAutoresizingMaskIntoConstraints = false
        
        symbolName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        symbolName.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        
        
        lastPrice.translatesAutoresizingMaskIntoConstraints = false
        
        lastPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        lastPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}
