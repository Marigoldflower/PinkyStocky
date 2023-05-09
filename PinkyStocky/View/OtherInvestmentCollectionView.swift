//
//  OtherInvestmentView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/06.
//

import UIKit

class OtherInvestmentCollectionView: UIView {
    
    
    var eurUSDData: RealTimeData? {
        didSet {
            print("eurUSD 값이 들어왔습니다 <<! \(eurUSDData)")
            guard let eurUSDData = eurUSDData else { return }
            eurUSD.symbolName.text = eurUSDData.symbol
            eurUSD.currentPrice.text = eurUSDData.close

            
            guard let change = Double(eurUSDData.change) else { return }
            
            if change < 0 {
                eurUSD.priceChange.backgroundColor = .autumnBlue
                eurUSD.priceChange.text = eurUSDData.percentChange
            } else {
                eurUSD.priceChange.backgroundColor  = .autumnPink
                eurUSD.priceChange.text = eurUSDData.percentChange
            }
        }
    }
    
    var gbpUSDData: RealTimeData? {
        didSet {
            print("gbpUSD 값이 들어왔습니다 <<! \(gbpUSDData)")
            guard let gbpUSDData = gbpUSDData else { return }
            gbpUSD.symbolName.text = gbpUSDData.symbol
            gbpUSD.currentPrice.text = gbpUSDData.close
            
            guard let change = Double(gbpUSDData.change) else { return }
            
            if change < 0 {
                gbpUSD.priceChange.backgroundColor = .autumnBlue
                gbpUSD.priceChange.text = gbpUSDData.percentChange
            } else {
                gbpUSD.priceChange.backgroundColor  = .autumnPink
                gbpUSD.priceChange.text = gbpUSDData.percentChange
            }
            
        }
    }
    
    var btcUSDData: RealTimeData? {
        didSet {
            print("btcUSD 값이 들어왔습니다 <<! \(btcUSDData)")
            guard let btcUSDData = btcUSDData else { return }
            btcUSD.symbolName.text = btcUSDData.symbol
            btcUSD.currentPrice.text = btcUSDData.close
            
            guard let change = Double(btcUSDData.change) else { return }
            
            if change < 0 {
                btcUSD.priceChange.backgroundColor = .autumnBlue
                btcUSD.priceChange.text = btcUSDData.percentChange
            } else {
                btcUSD.priceChange.backgroundColor  = .autumnPink
                btcUSD.priceChange.text = btcUSDData.percentChange
            }
            
        
        }
    }
    
    var ethUSDData: RealTimeData? {
        didSet {
            print("ethUSD 값이 들어왔습니다 <<! \(ethUSDData)")
            guard let ethUSDData = ethUSDData else { return }
            ethUSD.symbolName.text = ethUSDData.symbol
            ethUSD.currentPrice.text = ethUSDData.close
            
            guard let change = Double(ethUSDData.change) else { return }
            
            if change < 0 {
                ethUSD.priceChange.backgroundColor = .autumnBlue
                ethUSD.priceChange.text = ethUSDData.percentChange
            } else {
                ethUSD.priceChange.backgroundColor  = .autumnPink
                ethUSD.priceChange.text = ethUSDData.percentChange
            }
            
        }
    }

    
    lazy var eurUSD: OtherInvestmentView = {
        let view = OtherInvestmentView()
        view.backgroundColor = .dataPink
        view.symbolName.text = "EUR/USD"
        return view
    }()
    
    
    lazy var gbpUSD: OtherInvestmentView = {
        let view = OtherInvestmentView()
        view.backgroundColor = .dataPink
        view.symbolName.text = "GBP/USD"
        return view
    }()
    
    
    lazy var btcUSD: OtherInvestmentView = {
        let view = OtherInvestmentView()
        view.backgroundColor = .dataPink
        view.symbolName.text = "BTC/USD"
        return view
    }()
    
    
    lazy var ethUSD: OtherInvestmentView = {
        let view = OtherInvestmentView()
        view.backgroundColor = .dataPink
        view.symbolName.text = "ETH/USD"
        return view
    }()
    
    
    

    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()

    
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        setupLayout()
        fillStackView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // ⭐️ 가장 중요한 부분이 이 부분이다. 스크롤 방향이 가로 방향이면 heightAnchor로, 세로 방향이면 widthAnchor로 설정하라 ⭐️
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    
    private func fillStackView() {
        let companyArray = [eurUSD, gbpUSD, btcUSD, ethUSD]
        for company in companyArray {
            var elementView = UIView()
            elementView = company
            elementView.layer.cornerRadius = 8
            elementView.layer.masksToBounds = true
            elementView.translatesAutoresizingMaskIntoConstraints = false
            // ⭐️ 스크롤 방향이 세로 방향이면 widthAnchor에 값을 할당하는 부분은 지워도 된다.
            elementView.widthAnchor.constraint(equalToConstant: 240).isActive = true
            // ⭐️ 스크롤 방향이 가로 방향이면 heightAnchor에 값을 할당하는 부분은 지워도 된다.
//            elementView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
            stackView.addArrangedSubview(elementView)
        }
    }
    



}
