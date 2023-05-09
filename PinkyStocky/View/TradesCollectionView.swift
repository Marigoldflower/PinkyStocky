//
//  TradesCollectionView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/04.
//

import UIKit
import SDWebImage



class TradesCollectionView: UIView {
    
    
    
    // MARK: - Not Real Time Stock Data
    
    var appleArray: [Double] = [] {
        didSet {
            print("apple값이 이곳에 들어왔습니다!! << \(appleArray.count)")
            let todayPriceLabel = round(self.appleArray[self.appleArray.endIndex - 1] * 100) / 100
            let yesterdayPriceLabel = round(self.appleArray[self.appleArray.endIndex - 2] * 100) / 100
            let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100

            apple.lastPrice.text = "\(todayPriceLabel)"
            if changeLabel < 0 {
                apple.priceChangedPercentageLabel.backgroundColor = .autumnBlue
                apple.priceChangedPercentageLabel.text = "\(changeLabel)"
            } else {
                apple.priceChangedPercentageLabel.backgroundColor = .autumnPink
                apple.priceChangedPercentageLabel.text = "\(changeLabel)"
            }
        }
    }
    
    var teslaArray: [Double] = [] {
        didSet {
            print("tesla값이 이곳에 들어왔습니다!! << \(teslaArray.count)")
            let todayPriceLabel = round(self.teslaArray[self.teslaArray.endIndex - 1] * 100) / 100
            let yesterdayPriceLabel = round(self.teslaArray[self.teslaArray.endIndex - 2] * 100) / 100
            let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
            
            tesla.lastPrice.text = "\(todayPriceLabel)"
            if changeLabel < 0 {
                tesla.priceChangedPercentageLabel.backgroundColor = .autumnBlue
                tesla.priceChangedPercentageLabel.text = "\(changeLabel)"
            } else {
                tesla.priceChangedPercentageLabel.backgroundColor = .autumnPink
                tesla.priceChangedPercentageLabel.text = "\(changeLabel)"
            }
        }
    }
    
    var microsoftArray: [Double] = [] {
        didSet {
            print("microsoft값이 이곳에 들어왔습니다!!<< \(microsoftArray.count)")
            let todayPriceLabel = round(self.microsoftArray[self.microsoftArray.endIndex - 1] * 100) / 100
            let yesterdayPriceLabel = round(self.microsoftArray[self.microsoftArray.endIndex - 2] * 100) / 100
            let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
            
            microsoft.lastPrice.text = "\(todayPriceLabel)"
            if changeLabel < 0 {
                microsoft.priceChangedPercentageLabel.backgroundColor = .autumnBlue
                microsoft.priceChangedPercentageLabel.text = "\(changeLabel)"
            } else {
                microsoft.priceChangedPercentageLabel.backgroundColor = .autumnPink
                microsoft.priceChangedPercentageLabel.text = "\(changeLabel)"
            }
        }
    }
    
    var nVidiaArray: [Double] = [] {
        didSet {
            print("nVidia값이 이곳에 들어왔습니다!!<< \(nVidiaArray.count)")
            let todayPriceLabel = round(self.nVidiaArray[self.nVidiaArray.endIndex - 1] * 100) / 100
            let yesterdayPriceLabel = round(self.nVidiaArray[self.nVidiaArray.endIndex - 2] * 100) / 100
            let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
             
            nVidia.lastPrice.text = "\(todayPriceLabel)"
            if changeLabel < 0 {
                nVidia.priceChangedPercentageLabel.backgroundColor = .autumnBlue
                nVidia.priceChangedPercentageLabel.text = "\(changeLabel)"
            } else {
                nVidia.priceChangedPercentageLabel.backgroundColor = .autumnPink
                nVidia.priceChangedPercentageLabel.text = "\(changeLabel)"
            }
        }
    }
    
    var amazoneArray: [Double] = [] {
        didSet {
            print("amazone값이 이곳에 들어왔습니다!!<< \(amazoneArray.count)")
            let todayPriceLabel = round(self.amazoneArray[self.amazoneArray.endIndex - 1] * 100) / 100
            let yesterdayPriceLabel = round(self.amazoneArray[self.amazoneArray.endIndex - 2] * 100) / 100
            let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
            
            amazon.lastPrice.text = "\(todayPriceLabel)"
            if changeLabel < 0 {
                amazon.priceChangedPercentageLabel.backgroundColor = .autumnBlue
                amazon.priceChangedPercentageLabel.text = "\(changeLabel)"
            } else {
                amazon.priceChangedPercentageLabel.backgroundColor = .autumnPink
                amazon.priceChangedPercentageLabel.text = "\(changeLabel)"
            }
        }
    }
    
    var googleArray: [Double] = [] {
        didSet {
            print("google값이 이곳에 들어왔습니다!!<< \(googleArray.count)")
            
            let todayPriceLabel = round(self.googleArray[self.googleArray.endIndex - 1] * 100) / 100
            let yesterdayPriceLabel = round(self.googleArray[self.googleArray.endIndex - 2] * 100) / 100
            let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
            
            google.lastPrice.text = "\(todayPriceLabel)"
            if changeLabel < 0 {
                google.priceChangedPercentageLabel.backgroundColor = .autumnBlue
                google.priceChangedPercentageLabel.text = "\(changeLabel)"
            } else {
                google.priceChangedPercentageLabel.backgroundColor = .autumnPink
                google.priceChangedPercentageLabel.text = "\(changeLabel)"
            }
        }
        
        
    }
    
    

    lazy var apple: CompanyView = {
        let view = CompanyView()
        view.backgroundColor = .dataPink
        view.companyImageView.sd_setImage(with: self.setupLogoURL(companyName: "apple"))
        view.symbolName.text = "AAPL"
        view.descriptionName.text = "Apple Inc."
        return view
    }()
    
    
    lazy var tesla: CompanyView = {
        let view = CompanyView()
        view.backgroundColor = .dataPink
        view.companyImageView.sd_setImage(with: self.setupLogoURL(companyName: "tesla"))
        view.symbolName.text = "TSLA"
        view.descriptionName.text = "Tesla Inc."
        return view
    }()
    
    
    lazy var nVidia: CompanyView = {
        let view = CompanyView()
        view.backgroundColor = .dataPink
        view.companyImageView.sd_setImage(with: self.setupLogoURL(companyName: "nVidia"))
        view.symbolName.text = "NVDA"
        view.descriptionName.text = "NVidia Corp."
        return view
    }()
    
    
    lazy var microsoft: CompanyView = {
        let view = CompanyView()
        view.backgroundColor = .dataPink
        view.companyImageView.sd_setImage(with: self.setupLogoURL(companyName: "Microsoft"))
        view.symbolName.text = "MSFT"
        view.descriptionName.text = "Microsoft Corp."
        return view
    }()
    
    
    
    lazy var amazon: CompanyView = {
        let view = CompanyView()
        view.backgroundColor = .dataPink
        view.companyImageView.sd_setImage(with: self.setupLogoURL(companyName: "amazon"))
        view.symbolName.text = "AMZN"
        view.descriptionName.text = "Amazon.com Inc."
        return view
    }()
    
    
    lazy var google: CompanyView = {
        let view = CompanyView()
        view.backgroundColor = .dataPink
        view.companyImageView.sd_setImage(with: self.setupLogoURL(companyName: "google"))
        view.symbolName.text = "GOOG"
        view.descriptionName.text = "Alphabet Inc."
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
    
    
    private func setupLogoURL(companyName: String) -> URL? {
        guard let url = URL(string: "https://logo.clearbit.com/\(companyName).com") else { return URL(string: "") }
        return url
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
        let companyArray = [apple, tesla, microsoft, nVidia, amazon, google]
        for company in companyArray {
            var elementView = UIView()
            elementView = company
            elementView.layer.cornerRadius = 8
            elementView.layer.masksToBounds = true
            elementView.translatesAutoresizingMaskIntoConstraints = false
            // ⭐️ 스크롤 방향이 세로 방향이면 widthAnchor에 값을 할당하는 부분은 지워도 된다.
            elementView.widthAnchor.constraint(equalToConstant: 240).isActive = true
            // ⭐️ 스크롤 방향이 가로 방향이면 heightAnchor에 값을 할당하는 부분은 지워도 된다.
            elementView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
            stackView.addArrangedSubview(elementView)
        }
    }
}

