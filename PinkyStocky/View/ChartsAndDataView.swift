//
//  ChartsAndDataView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/28.
//

import UIKit

final class ChartsAndDataView: UIView {
    
    
    var stockChartsView = StockChartsView()
    var dataCollectionView = DataCollectionView()
    
    
    
    var codeName: String?
    
    var financialMetrics: Metric? {
        didSet {
            print("DEBUG: 현재 metrics 데이터가 잘 넘어왔습니다 \(financialMetrics)")
            setupDataCollection()
        }
    }
    
    
    var stockResultData: [Double]? {
        didSet {
            print("DEBUG: 현재 stock 데이터가 잘 넘어왔습니다 \(stockResultData?.count)")
            setupStockResultData()
        }
    }
    
    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stockChartsView, dataCollectionView])
        stack.spacing = 0
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    private func setupLayout() {
      
        dataCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        dataCollectionView.heightAnchor.constraint(equalToConstant: 74).isActive = true
      
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
       
    }
    
    
    
    
    
    private func setupDataCollection() {
        
        print("데이터가 잘 넘어왔습니다")
        
        guard let financialMetrics = self.financialMetrics else {
            DispatchQueue.main.async {
                
                print("metrics 데이터가 없는 경우가 잘 실행되고 있습니다")
                let label = UILabel()
                let stringOne = "Sorry No Data Found 😔"
                let stringTwo = "Sorry"
                
                let range = (stringOne as NSString).range(of: stringTwo)
                
                
                let attributedText = NSMutableAttributedString.init(string: stringOne)
                attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemPink, range: range)
                label.attributedText = attributedText
                
                label.font = .boldSystemFont(ofSize: 14)
                label.numberOfLines = 0
                label.textAlignment = .center
                
                self.dataCollectionView.emptyLabel.attributedText = label.attributedText
            }
            
            return
        }
        
        print("데이터가 잘 넘어왔습니다!!!!")
        
        
        DispatchQueue.main.async {
            self.dataCollectionView.the10DayAverageTradingVolume.attributedText = self.coloringLabel(stringOne: "10D Vol", stringTwo: financialMetrics.the10DayAverageTradingVolume)
            self.dataCollectionView.the52WeekLow.attributedText = self.coloringLabel(stringOne: "52W Low", stringTwo: financialMetrics.the52WeekLow)
            self.dataCollectionView.the52WeekHigh.attributedText = self.coloringLabel(stringOne: "52W High", stringTwo: financialMetrics.the52WeekHigh)
            self.dataCollectionView.the52WeekPriceReturnDaily.attributedText = self.coloringLabel(stringOne: "52W Return", stringTwo: financialMetrics.the52WeekPriceReturnDaily)
            self.dataCollectionView.beta.attributedText = self.coloringLabel(stringOne: "Beta", stringTwo: financialMetrics.beta)
        }
        
    }
    
    
    
    
    private func setupStockResultData() {
        
        if self.stockResultData?.count == 0 {
            DispatchQueue.main.async {
                
                self.stockChartsView.chartView.isHidden = true
                print("metrics 데이터가 없는 경우가 잘 실행되고 있습니다")
                
                let label = UILabel()
                let stringOne = "Sorry No Data Found 😔"
                let stringTwo = "Sorry"
                
                let range = (stringOne as NSString).range(of: stringTwo)
                
                
                let attributedText = NSMutableAttributedString.init(string: stringOne)
                attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemPink, range: range)
                label.attributedText = attributedText
                
                label.font = .boldSystemFont(ofSize: 14)
                label.numberOfLines = 0
                label.textAlignment = .center
                
                self.stockChartsView.emptyLabel.attributedText = label.attributedText
            }
            
            return
        }
        
        
        DispatchQueue.main.async {
            print("stockResultData의 개수는 \(self.stockResultData?.count ?? 0)입니다. 지금 잘 되고 있죠?")
            self.stockChartsView.marketResultData = self.stockResultData ?? []
        }
        
        
    }
    
    
    

    private func coloringLabel(stringOne: String, stringTwo: Double) -> NSAttributedString {
        let label = UILabel()
        let stringOne = "\(stringOne): \(stringTwo)"
        let stringTwo = "\(stringTwo)"

        let range = (stringOne as NSString).range(of: stringTwo)

        let attributedText = NSMutableAttributedString.init(string: stringOne)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.headerPink, range: range)
        label.attributedText = attributedText
        return label.attributedText!
    }
    
    
}


