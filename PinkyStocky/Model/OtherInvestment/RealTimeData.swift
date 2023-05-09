//
//  Forex.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/08.
//

import Foundation

// MARK: - RealTimeData
struct RealTimeData: Codable {
    let symbol: String
//    let datetime: String
//    let timestamp: TimeInterval
    let realTimeDataOpen, high, low, close: String
    let previousClose, change, percentChange: String
    let isMarketOpen: Bool
    

    enum CodingKeys: String, CodingKey {
        case symbol
//        case datetime
//        case timestamp
        case realTimeDataOpen = "open"
        case high, low, close
        case previousClose = "previous_close"
        case change
        case percentChange = "percent_change"
        case isMarketOpen = "is_market_open"
        
    }
}




// 실험할 것들
//
//struct RealTimeData: Codable {
//    let symbol, name, exchange, datetime: String
//    let timestamp: Int
//    let realTimeDataOpen, high, low, close: String
//    let previousClose, change, percentChange, averageVolume: String
//    let rolling1DChange, rolling7DChange, rollingChange: String
//    let isMarketOpen: Bool
//    let fiftyTwoWeek: FiftyTwoWeek
//
//    enum CodingKeys: String, CodingKey {
//        case symbol, name, exchange, datetime, timestamp
//        case realTimeDataOpen = "open"
//        case high, low, close
//        case previousClose = "previous_close"
//        case change
//        case percentChange = "percent_change"
//        case averageVolume = "average_volume"
//        case rolling1DChange = "rolling_1d_change"
//        case rolling7DChange = "rolling_7d_change"
//        case rollingChange = "rolling_change"
//        case isMarketOpen = "is_market_open"
//        case fiftyTwoWeek = "fifty_two_week"
//    }
//}
//
//// MARK: - FiftyTwoWeek
//struct FiftyTwoWeek: Codable {
//    let low, high, lowChange, highChange: String
//    let lowChangePercent, highChangePercent, range: String
//
//    enum CodingKeys: String, CodingKey {
//        case low, high
//        case lowChange = "low_change"
//        case highChange = "high_change"
//        case lowChangePercent = "low_change_percent"
//        case highChangePercent = "high_change_percent"
//        case range
//    }
//}
//
//
//
