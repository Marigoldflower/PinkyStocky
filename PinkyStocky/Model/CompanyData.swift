//
//  CompanyData.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/15.

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)


import Foundation

// MARK: - Welcome
struct CompanyData: Codable {
    let result: [CompanyDataResult]
}

// MARK: - Result
// 네트워크 통신을 할 때 결과를 보여줘야 하는 struct 영역 내에는 enum 타입이 없어야 한다.
struct CompanyDataResult: Codable {
    let detailName: String // 원래는 Description이라는 enum 타입이 존재했으나, 짧게 String 타입으로 줄였다.
    let codeName: String
    
    enum CodingKeys: String, CodingKey {
        case detailName = "description"
        case codeName = "displaySymbol"
    }
}













