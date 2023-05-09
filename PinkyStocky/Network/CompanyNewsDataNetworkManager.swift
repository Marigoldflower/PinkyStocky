//
//  NewsDataNetworkManager.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/18.
//

import Foundation
import UIKit

enum CompanyNewsDataNetworkError: Error {
    case networkingError
    case dataError
    case parseError
}


final class CompanyNewsDataNetworkManager {
    
    // 여러 뷰 컨트롤러에서 통신을 한다면, 일반적으로 싱글톤 패턴으로 만든다.
    static let shared = CompanyNewsDataNetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    
    
    // 결론적으로 내가 받고 싶은 리턴 타입을 여기에 적어준다.
    // 결론적으로 받고 싶은 타입은 [MusicData] 타입이다.
    typealias NetworkCompletion = (Result<NewsDataArchive, CompanyNewsDataNetworkError>) -> Void
    
    // 네트워킹 요청하는 함수 (음악데이터 가져오기)
    // searchTerm은 나중에 개발자가 받고 싶은 데이터가 있을 때 입력하는 란이다.
    
    
    // ⭐️ 결론적으로 내가 받고 싶은 리턴 타입을 여기에 적어준다. ⭐️
    // 결론적으로 받고 싶은 타입은 [MusicData] 타입이다.
    func fetchNetwork(searchTerm: String, completion: @escaping NetworkCompletion) {
        let myAPIKey = "cficbc9r01qq9nt20eagcficbc9r01qq9nt20eb0"
        let toDate = Date()
        let fromDate = toDate - (86400 * 365)
        
        let formattter = DateFormatter()
        formattter.dateFormat = "yyyy-MM-dd"
        
        let today = formattter.string(from: toDate)
        let oneYearsAgo = formattter.string(from: fromDate)
        
        
        let urlString = "https://finnhub.io/api/v1/company-news?symbol=\(searchTerm)&from=\(oneYearsAgo)&to=\(today)&token=\(myAPIKey)"
        print(urlString)
        
        performRequest(with: urlString) { result in
            completion(result)
        }
        
    }
    
    // 실제 Request하는 함수 (비동기적 실행 ===> 클로저 방식으로 끝난 시점을 전달 받도록 설계)
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        //print(#function)
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                print("DEBUG: 네트워크 에러")
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                print("DEBUG: 데이터 에러")
                return
            }
            
            // 메서드 실행해서, 결과를 받음
            if let news = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(news))
            } else {
                print("DEBUG: Parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseJSON(_ newsData: Data) -> NewsDataArchive? {
        //print(#function)
        
        // 성공
        do {
            // 우리가 만들어 놓은 구조체(클래스 등)로 변환하는 객체와 메서드
            // (JSON 데이터 ====> MusicData 구조체)
            // ⭐️ 가장 상위에 있는 구조체를 메타타입으로 적는다. ⭐️
            let newsDataResponse = try JSONDecoder().decode(NewsDataArchive.self, from: newsData)
            print("DEBUG: JSON 파싱 완료")
            return newsDataResponse
            // 실패
        } catch {
            print(error.localizedDescription)
            print("DEBUG: JSON 파싱 에러!???!!")
            
            return nil
        }
    }
}

