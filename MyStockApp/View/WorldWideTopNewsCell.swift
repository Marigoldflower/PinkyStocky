//
//  TopNewsViewCell.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/18.
//

import UIKit


class WorldWideTopNewsCell: UICollectionViewCell {
    
    static let identifier = "TopNewsCell"
    
    
    // MARK: - 컬렉션 뷰 셀 객체
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .heavy)
        label.numberOfLines = 2
        return label
    }()
    
    
    let resultNumber: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    
    
    let upAndDownRate: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
   
    
    
    
    
    // MARK: - 스택 뷰
    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, resultNumber, upAndDownRate])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    
    // 컬렉션 뷰 셀에서 viewDidLoad 역할을 하는 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stackView)
        contentView.addSubview(chartView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setupConstraints() {

        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        chartView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    
    
//    func configureData() {
//        print("StockChartsmarketResultData에 담겼습니다 \(marketResultData.count)")
//
//
//        var entries: [ChartDataEntry] = []
//        for resultMarketPrice in 0..<marketResultData.count {
//            let value = ChartDataEntry(x: Double(resultMarketPrice), y: marketResultData[resultMarketPrice])
//            entries.append(value)
//        }
//
//
//        let dataSet = LineChartDataSet(entries: entries, label: "3 Days Data")
//
//
//        let todayPriceLabel = round(self.marketResultData[self.marketResultData.endIndex - 1] * 100) / 100
//        let yesterdayPriceLabel = round(self.marketResultData[self.marketResultData.endIndex - 2] * 100) / 100
//        let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
//
//        if changeLabel < 0 {
//            dataSet.fillColor = .autumnBlue
//            dataSet.colors = [.dataBlue]
//
//
//        } else {
//            dataSet.fillColor = .autumnPink
//            dataSet.colors = [.headerPink]
//
//        }
//
//        dataSet.drawFilledEnabled = true
//        dataSet.drawIconsEnabled = false
//        dataSet.drawValuesEnabled = false
//        dataSet.drawCirclesEnabled = false
//        let data = LineChartData(dataSet: dataSet)
//        chartView.data = data
//
//        print("차트가 담겼습니다")
//
//    }
//
    
    
}
