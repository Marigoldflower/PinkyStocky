//
//  WebSocketView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/31.
//

import UIKit
import Charts


class WebSocketNetworkView: UIView {
    
    
    
    let otherInvestmentCollectionView = OtherInvestmentCollectionView()
    let recommendationView = RecommendationView()
    let liveTradesCollectionView = TradesCollectionView()
    
    
    
    // MARK: - otherInvestmentCollectionView
    
    var eurUSD: RealTimeData? {
        didSet {
//            setupOtherInvestment()
            print("eurUSD 값이 들어왔습니다 \(eurUSD)")
        }
    }
    
    var gbpUSD: RealTimeData? {
        didSet {
            
        }
    }
    
    var btcUSD: RealTimeData? {
        didSet {
            
        }
    }
    
    var ethUSD: RealTimeData? {
        didSet {
            
        }
    }
    
    
    
    // MARK: - liveTradesCollectionView
  
    var appleArray: [Double] = [] {
        didSet {
            print("apple값이 이곳에 들어왔습니다!! \(appleArray)")
            setupDatas()
        }
    }
    
    var teslaArray: [Double] = [] {
        didSet {
            print("tesla값이 이곳에 들어왔습니다!! \(teslaArray)")
        }
    }
    
    var microsoftArray: [Double] = [] {
        didSet {
            print("microsoft값이 이곳에 들어왔습니다!! \(microsoftArray)")
        }
    }
    
    var nVidiaArray: [Double] = [] {
        didSet {
            print("nVidia값이 이곳에 들어왔습니다!! \(nVidiaArray)")
        }
    }
    
    var amazoneArray: [Double] = [] {
        didSet {
            print("amazone값이 이곳에 들어왔습니다!! \(amazoneArray)")
        }
    }
    
    var googleArray: [Double] = [] {
        didSet {
            print("google값이 이곳에 들어왔습니다!! \(googleArray)")
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(otherInvestmentCollectionView)
        self.addSubview(recommendationView)
        self.addSubview(liveTradesCollectionView)
        setupLayout()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupLayout() {
        
        otherInvestmentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        otherInvestmentCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        otherInvestmentCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        otherInvestmentCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        otherInvestmentCollectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        recommendationView.translatesAutoresizingMaskIntoConstraints = false
        
        recommendationView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        recommendationView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        recommendationView.bottomAnchor.constraint(equalTo: liveTradesCollectionView.topAnchor, constant: -8).isActive = true
        recommendationView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        
        liveTradesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        liveTradesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        liveTradesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        liveTradesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        liveTradesCollectionView.heightAnchor.constraint(equalToConstant: 85).isActive = true
    }
    
    
    func setupDatas() {
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.main.async {
            self.otherInvestmentCollectionView.eurUSDData = self.eurUSD
            self.otherInvestmentCollectionView.gbpUSDData = self.gbpUSD
            self.otherInvestmentCollectionView.btcUSDData = self.btcUSD
            self.otherInvestmentCollectionView.ethUSDData = self.ethUSD
        }
        group.leave()
        

        
      
        DispatchQueue.main.async {
            self.liveTradesCollectionView.appleArray = self.appleArray
            self.liveTradesCollectionView.teslaArray = self.teslaArray
            self.liveTradesCollectionView.microsoftArray = self.microsoftArray
            self.liveTradesCollectionView.nVidiaArray = self.nVidiaArray
            self.liveTradesCollectionView.amazoneArray = self.amazoneArray
            self.liveTradesCollectionView.googleArray = self.googleArray
        }
        
    }
    

}
