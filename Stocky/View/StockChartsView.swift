//
//  ChartsView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/03.
//

import UIKit
import Foundation
import Charts




class StockChartsView: UIView {

    
    // 지금 네트워크 통신의 문제점: 네트워크 통신보다 View가 먼저 그려짐으로 인해 배열이 비는 상황이 발생
    
    // viewDidLoad에 configureData()를 할당해선 안 되는 이유는 configureData() 그 자체에는 데이터가 존재하지 않기 때문이다. 즉 didSet을 이용해 marketResultData에 값이 들어오는 순간 configureData()를 실행시키도록 코드 로직을 짜야 configureData()에 값이 들어간다.
    var marketResultData: [Double] = [] {
        didSet {
            configureData()
        }
    }
    
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    var chartView: LineChartView = {
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
        backgroundColor = .pinkBeige
        addSubview(chartView)
        addSubview(emptyLabel)
        setupConstraints()

        
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    func setupConstraints() {
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        chartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        chartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        chartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emptyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    func configureData() {
        print("StockChartsmarketResultData에 담겼습니다 \(marketResultData.count)")
        
        
        var entries: [ChartDataEntry] = []
        for resultMarketPrice in 0..<marketResultData.count {
            let value = ChartDataEntry(x: Double(resultMarketPrice), y: marketResultData[resultMarketPrice])
            entries.append(value)
        }
        
        
        let dataSet = LineChartDataSet(entries: entries, label: "3 Days Data")
        
        
        let todayPriceLabel = round(self.marketResultData[self.marketResultData.endIndex - 1] * 100) / 100
        let yesterdayPriceLabel = round(self.marketResultData[self.marketResultData.endIndex - 2] * 100) / 100
        let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
        
        if changeLabel < 0 {
            dataSet.fillColor = .autumnBlue
            dataSet.colors = [.dataBlue]
            
            
        } else {
            dataSet.fillColor = .autumnPink
            dataSet.colors = [.headerPink]
            
        }
        
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
        
        print("차트가 담겼습니다")
        
    }
 
}
