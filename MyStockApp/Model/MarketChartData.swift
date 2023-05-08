//
//  MarketDataResponse.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/07.
//

import Foundation

struct MarketData: Codable {
    let open: [Double]
    let close: [Double]
    let high: [Double]
    let low: [Double]
    let status: String
    let timeStamps: [Int]
    
    enum CodingKeys: String, CodingKey {
        case open = "o"
        case close = "c"
        case high = "h"
        case low = "l"
        case status = "s"
        case timeStamps = "t"
    }
    
    
    var candleSticks: [CandleSticks] {
        var result: [CandleSticks] = []
        for index in 0..<open.count {
            result.append(.init(date: timeStamps[index], open: open[index], close: close[index], high: high[index], low: low[index]))
        }
        
        let sortedData = result.sorted { $0.date < $1.date }
        return sortedData
    }
}



struct CandleSticks {
    let date: Int
    let open: Double
    let close: Double
    let high: Double
    let low: Double
}
