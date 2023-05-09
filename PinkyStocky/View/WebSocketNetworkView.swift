//
//  WebSocketView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/31.
//

import UIKit
import Charts


class WebSocketNetworkView: UIView {
    
    
//    let webSocketNetworkCollection = WebSocketNetworkCollection()
    
    let otherInvestmentCollectionView = OtherInvestmentCollectionView()
    let recommendationView = RecommendationView()
    let liveTradesCollectionView = TradesCollectionView()

    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [otherInvestmentCollectionView, recommendationView, liveTradesCollectionView])
        stack.axis = .vertical
        stack.spacing = 13
        stack.distribution = .fill
        return stack
    }()


    // MARK: - otherInvestmentCollectionView

    var eurUSD: RealTimeData? {
        didSet {
//            setupOtherInvestment()
            print("eurUSD 값이 들어왔습니다앙!~! \(eurUSD)")
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
//        self.addSubview(webSocketNetworkCollection)
//        self.addSubview(otherInvestmentCollectionView)
//        self.addSubview(recommendationView)
//        self.addSubview(liveTradesCollectionView)
        self.addSubview(stackView)
        setupLayout()

    }


    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupLayout() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        
        
        otherInvestmentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        otherInvestmentCollectionView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        
        recommendationView.translatesAutoresizingMaskIntoConstraints = false
        
        recommendationView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    
        

    }


    private func setupDatas() {

       
        DispatchQueue.main.async {
            self.otherInvestmentCollectionView.eurUSDData = self.eurUSD
            self.otherInvestmentCollectionView.gbpUSDData = self.gbpUSD
            self.otherInvestmentCollectionView.btcUSDData = self.btcUSD
            self.otherInvestmentCollectionView.ethUSDData = self.ethUSD
        }


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
