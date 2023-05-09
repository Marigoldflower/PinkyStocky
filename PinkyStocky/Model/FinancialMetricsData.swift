//
//  FinancialMetricsData.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/28.
//

import Foundation

// MARK: - Welcome
struct MetricData: Codable {
    let metric: Metric
}

// MARK: - Metric
struct Metric: Codable {
    let the10DayAverageTradingVolume: Double
    let the52WeekHigh: Double
    let the52WeekLow: Double
    let the52WeekPriceReturnDaily: Double
    let beta: Double
   

    enum CodingKeys: String, CodingKey {
        case the10DayAverageTradingVolume = "10DayAverageTradingVolume"
        case the52WeekHigh = "52WeekHigh"
        case the52WeekLow = "52WeekLow"
        case the52WeekPriceReturnDaily = "52WeekPriceReturnDaily"
        case beta
    }
}


