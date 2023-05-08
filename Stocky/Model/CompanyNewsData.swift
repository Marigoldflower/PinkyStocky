//
//  NewsData.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/18.
//




// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)



/*
 {
     "category": "company",
     "datetime": 1675968480,
     "headline": "Trump has regained access to Facebook, Instagram accounts: WSJ",
     "id": 118523882,
     "image": "https://media.zenfs.com/en/marketwatch.com/96d076434b2a015a3010bd2787b8c856",
     "related": "META",
     "source": "Yahoo",
     "summary": "Former President Donald Trump regained control of his Facebook and Instagram accounts this week, the Wall Street Journal reported on Thursday.  The move follows a decision last month by Meta Platforms Inc.  (META)  the parent company of the two social-media platforms, to allow Trump to regain access to the accounts, following a two-year ban in the wake of the Jan. 6 Capitol riots in 2021.  A representative for Trump was not immediately available for comment.",
     "url": "https://finnhub.io/api/news?id=15815c080eb3f3ba81792cb19b8227f8ff07e801af27c44a120ffb297d0002f4"
   }
 
 */



import Foundation

// MARK: - WelcomeElement
struct CompanyNewsData: Codable {
    let datetime: Int
    let newsTitle: String
    let imageURL: String
//    let codeName: String
    let publisher: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case datetime
        case newsTitle = "headline"
        case imageURL = "image"
//        case codeName = "related"
        case publisher = "source"
        case url
    }
    
    var dateTimeString: String? {
        let formatter = DateFormatter()
        let epochTime = TimeInterval(datetime)
        let date = Date(timeIntervalSince1970: epochTime)
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        
        return result
    }
    
    var imageSDURL: URL? {
        guard let url = URL(string: imageURL) else { return URL(string: "") }
        return url
    }
    
}



typealias NewsDataArchive = [CompanyNewsData]
