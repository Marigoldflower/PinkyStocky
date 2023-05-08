//
//  MarketDataResponse.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/07.
//

import Foundation

struct MarketChartData: Codable {
    let open: [Double]
    let close: [Double]
    let high: [Double]
    let low: [Double]
    let status: String
    let timeStamps: [TimeInterval]
    
    enum CodingKeys: String, CodingKey {
        case open = "o"
        case close = "c"
        case high = "h"
        case low = "l"
        case status = "s"
        case timeStamps = "t"
    }
    
}


