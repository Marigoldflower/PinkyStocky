//
//  S&P500ChartsView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/15.
//

import UIKit
import Charts


protocol ReloadButtonDelegate: AnyObject {
    func reloadButtonTapped(_ sp500ChartsView: SP500ChartsView)
}


final class SP500ChartsView: UIView {

    
    var delegate: ReloadButtonDelegate?
    
    
    let sp500FullName: UILabel = {
        let label = UILabel()
        label.text = "SPDR S&P 500 ETF Trust"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .headerPink
        label.textAlignment = .center
        return label
    }()
    
    
    let changeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        return label
    }()
    
    
    
    let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .autumnPink
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    
    
    lazy var stackViewsp500: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sp500FullName, changeLabel])
        stack.axis = .horizontal
        stack.spacing = 6
        stack.distribution = .fill
        return stack
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
    
    
    
    var marketResultData: [Double] = [] {
        didSet {
            configureData()
            print("marketResultData S&P500 표 값이 들어왔습니다 \(marketResultData.count)")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .pinkBeige
        self.addSubview(stackViewsp500)
        self.addSubview(reloadButton)
        self.addSubview(chartView)
        setupConstraints()
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }
    
    
    

    required init?(coder: NSCoder) {
        fatalError()
    }
    

    @objc private func reloadButtonTapped() {
        delegate?.reloadButtonTapped(self)
    }
    
    private func setupConstraints() {
        
        
        chartView.translatesAutoresizingMaskIntoConstraints = false

        chartView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        chartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        chartView.topAnchor.constraint(equalTo: stackViewsp500.bottomAnchor, constant: 10).isActive = true
        chartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
        sp500FullName.translatesAutoresizingMaskIntoConstraints = false
        
        sp500FullName.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        
        
        
        stackViewsp500.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewsp500.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackViewsp500.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        
        
        reloadButton.translatesAutoresizingMaskIntoConstraints = false

        reloadButton.leadingAnchor.constraint(equalTo: stackViewsp500.trailingAnchor, constant: 10).isActive = true
        reloadButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 17).isActive = true
        reloadButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true

        
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        changeLabel.widthAnchor.constraint(equalToConstant: 43).isActive = true
        

    }
    
    
    private func configureData() {
        print("marketResultData에 담겼습니다 \(marketResultData.count)")
        
        if marketResultData.isEmpty {
            
        }
        
        
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
