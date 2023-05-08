//
//  MarketDataNetworkManager.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/07.
//

import Foundation


enum MarketChartDataNetworkError: Error {
    case networkingError
    case dataError
    case parseError
}


final class MarketChartDataNetworkManager {
    
    // 여러 뷰 컨트롤러에서 통신을 한다면, 일반적으로 싱글톤 패턴으로 만든다.
    static let shared = MarketChartDataNetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    //let musicURL = "https://itunes.apple.com/search?media=music"
    
        // 결론적으로 내가 받고 싶은 리턴 타입을 여기에 적어준다.
        // 결론적으로 받고 싶은 타입은 [MusicData] 타입이다.
    typealias NetworkCompletion = (Result<MarketChartData, MarketChartDataNetworkError>) -> Void

        // ⭐️ 결론적으로 내가 받고 싶은 리턴 타입을 여기에 적어준다. ⭐️
        // 결론적으로 받고 싶은 타입은 [MusicData] 타입이다.
    func fetchNetwork(searchTerm: String, completion: @escaping NetworkCompletion) {
        
        let myAPIKey = "cficbc9r01qq9nt20eagcficbc9r01qq9nt20eb0"
        
        // 1. from과 to의 시간을 설정해주기 위해서 유닉스 시간을 설정해줘야 함
        // 유닉스 시간은 timeIntervalSince1970으로 1970년으로부터 몇 초가 흘렀는지를 의미함
        
        // 날짜를 오늘로 설정하면 close price가 찍히지 않을 수가 있음
        // 주식 시장이 닫혀야 비로소 오늘의 close price가 찍히기 때문이다.
        // 
        let toDate = Date()
        let fromDate = toDate - (86400 * 3)
        
        let formattter = DateFormatter()
        formattter.dateFormat = "yyyy-MM-dd"
        
        // Date 타입을 유닉스시간으로 변환해주는 프로퍼티 (TimeInterval 타입)
        let today = Int(toDate.timeIntervalSince1970)
        
        // Date 타입을 유닉스시간으로 변환해주는 프로퍼티 (TimeInterval 타입)
        let threeDaysAgo = Int(fromDate.timeIntervalSince1970)
        
        
        let urlString = "https://finnhub.io/api/v1/stock/candle?symbol=\(searchTerm)&resolution=1&from=\(threeDaysAgo)&to=\(today)&token=\(myAPIKey)"
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
            if let music = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(music))
            } else {
                print("DEBUG: Parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseJSON(_ marketData: Data) -> MarketChartData? {
        //print(#function)
    
        // 성공
        do {
            // 우리가 만들어 놓은 구조체(클래스 등)로 변환하는 객체와 메서드
            // (JSON 데이터 ====> MusicData 구조체)
                        // ⭐️ 가장 상위에 있는 구조체를 메타타입으로 적는다. ⭐️
            let marketData = try JSONDecoder().decode(MarketChartData.self, from: marketData)
            return marketData
        // 실패
        } catch {
            print(error)
                        print("DEBUG: JSON 파싱 에러!!!!")
            return nil
        }
    }
}
