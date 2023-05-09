//
//  NewYorkTimesJournalData.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/25.
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let journal = try? JSONDecoder().decode(Journal.self, from: jsonData)


import Foundation

// MARK: - WorldWideNews
struct WorldWideNews: Codable {
    let worldWideNewsData: [WorldWideNewsData]
    
    enum CodingKeys: String, CodingKey {
        case worldWideNewsData = "articles"
    }
}

// MARK: - Article
struct WorldWideNewsData: Codable {
    let author: String?
    let newsTitle: String
    let newsDescription: String?
    let url: String
    let imageURL: String?
//    let publishedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case author
        case newsTitle = "title"
        case newsDescription = "description"
        case url
        case imageURL = "urlToImage"
//        case publishedAt
    }
    
    
    var imageSDURL: URL? {
        guard let url = URL(string: imageURL ?? "") else { return URL(string: "") }
        return url
    }
}

