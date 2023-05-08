//
//  Forex.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/08.
//

import Foundation

// MARK: - RealTimeData
struct RealTimeData: Codable {
    let symbol, name: String
    let datetime: String
    let timestamp: Int
    let realTimeDataOpen, high, low, close: String
    let previousClose, change, percentChange: String
    let isMarketOpen: Bool
    

    enum CodingKeys: String, CodingKey {
        case symbol, name
        case datetime
        case timestamp
        case realTimeDataOpen = "open"
        case high, low, close
        case previousClose = "previous_close"
        case change
        case percentChange = "percent_change"
        case isMarketOpen = "is_market_open"
        
    }
}


