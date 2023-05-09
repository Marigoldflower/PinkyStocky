//
//  NewsDataNetworkManager.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/18.
//

import Foundation


enum RealTimetNetworkError: Error {
    case networkingError
    case dataError
    case parseError
}


final class RealTimeNetworkManager {
    
    // 여러 뷰 컨트롤러에서 통신을 한다면, 일반적으로 싱글톤 패턴으로 만든다.
    static let shared = RealTimeNetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    //let musicURL = "https://itunes.apple.com/search?media=music"
    
        // 결론적으로 내가 받고 싶은 리턴 타입을 여기에 적어준다.
        // 결론적으로 받고 싶은 타입은 [MusicData] 타입이다.
    typealias NetworkCompletion = (Result<RealTimeData, RealTimetNetworkError>) -> Void

    // 네트워킹 요청하는 함수 (음악데이터 가져오기)
        // searchTerm은 나중에 개발자가 받고 싶은 데이터가 있을 때 입력하는 란이다.


        // ⭐️ 결론적으로 내가 받고 싶은 리턴 타입을 여기에 적어준다. ⭐️
        // 결론적으로 받고 싶은 타입은 [MusicData] 타입이다.
    func fetchNetwork(searchTerm: String, completion: @escaping NetworkCompletion) {
        
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.string(from: today)
        
        let myAPIKey = "e94f97bf158743928e4c40929b0e92b7"
        
        let urlString = "https://api.twelvedata.com/quote?symbol=\(searchTerm)&apikey=\(myAPIKey)&source=docs"
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
    private func parseJSON(_ realtime: Data) -> RealTimeData? {
        //print(#function)
    
        // 성공
        do {
            // 우리가 만들어 놓은 구조체(클래스 등)로 변환하는 객체와 메서드
            // (JSON 데이터 ====> MusicData 구조체)
                        // ⭐️ 가장 상위에 있는 구조체를 메타타입으로 적는다. ⭐️
            let real = try JSONDecoder().decode(RealTimeData.self, from: realtime)
            return real
            // 실패
        } catch {
            print(error)
            print("DEBUG: RealTimeData 파싱 실패 ㅠㅠ")
            return nil
        }
    }
}
