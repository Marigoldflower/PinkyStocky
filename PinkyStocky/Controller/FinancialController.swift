//
//  FinancialController.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/04.
//

import UIKit
import SDWebImage
import SafariServices


class FinancialController: UIViewController {
    
    
    let tableView = UITableView()
    
    
    var newsDataNetworkManager = FinancialNewsDataNetworkMananger.shared
    var financialNewsArray: NewsCollection = []
    

    var marketChartDataNetworkManager = MarketChartDataNetworkManager.shared
    var appleArray: [Double] = []
    var teslaArray: [Double] = []
    var microsoftArray: [Double] = []
    var nVidiaArray: [Double] = []
    var amazoneArray: [Double] = []
    var googleArray: [Double] = []
    
    
    var realTimeNetworkManager = RealTimeNetworkManager.shared
    var eurUSD: RealTimeData?
    var gbpUSD: RealTimeData?
    var btcUSD: RealTimeData?
    var ethUSD: RealTimeData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupTableView()
        setupLayout()
        setupLoadingView()
        setupTableViewDelegate()
        setupDatas()
        setupTableViewColor()
        setupRegister()
    }
    
    
    private func setupNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 내비게이션 바 투명하지 않게
        appearance.backgroundColor = .pinkBeige     // 내비게이션 바 색상설정
        
        // 내비게이션 바 버튼 색깔 설정 (< 이전으로 같은 버튼)
        navigationController?.navigationBar.tintColor = .tintPink
        
        // 내비게이션 바 Safe Area까지 꽉 차게 만들기
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        
        // 내비게이션 바 타이틀 설정
        navigationItem.title = "Financial"
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
    }
    
    
    
    
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    
    
    private func setupLoadingView() {
        let loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.28)))
        self.tableView.tableHeaderView = loadingView
        self.tableView.sectionHeaderTopPadding = 0.0
    }
    
    
    private func setupTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func setupTableViewColor() {
        self.tableView.backgroundColor = .pinkBeige
    }
    
    
    private func setupRegister() {
        self.tableView.register(NewsControllerCell.self, forCellReuseIdentifier: NewsControllerCell.identifier)
        self.tableView.register(NewsHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier)
    }
    
    
    private func setupDatas() {
        let group = DispatchGroup()
        
        group.enter()
        newsDataNetworkManager.fetchNetwork(searchTerm: "general") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let financial):
                // 데이터(배열)을 받아오고 난 후
                self.financialNewsArray = financial
            
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        group.enter()
        marketChartDataNetworkManager.fetchNetwork(searchTerm: "AAPL") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let marketChart):
                // 데이터(배열)을 받아오고 난 후
                self.appleArray = marketChart.close
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.enter()
        marketChartDataNetworkManager.fetchNetwork(searchTerm: "TSLA") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let marketChart):
                // 데이터(배열)을 받아오고 난 후
                self.teslaArray = marketChart.close
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        group.enter()
        marketChartDataNetworkManager.fetchNetwork(searchTerm: "MSFT") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let marketChart):
                // 데이터(배열)을 받아오고 난 후
                self.microsoftArray = marketChart.close
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        group.enter()
        marketChartDataNetworkManager.fetchNetwork(searchTerm: "NVDA") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let marketChart):
                // 데이터(배열)을 받아오고 난 후
                self.nVidiaArray = marketChart.close
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        group.enter()
        marketChartDataNetworkManager.fetchNetwork(searchTerm: "AMZN") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let marketChart):
                // 데이터(배열)을 받아오고 난 후
                self.amazoneArray = marketChart.close
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
        group.enter()
        marketChartDataNetworkManager.fetchNetwork(searchTerm: "GOOG") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let marketChart):
                // 데이터(배열)을 받아오고 난 후
                self.googleArray = marketChart.close
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.enter()
        realTimeNetworkManager.fetchNetwork(searchTerm: "EUR/USD") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let eurUSD):
                // 데이터(배열)을 받아오고 난 후
                self.eurUSD = eurUSD
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.enter()
        realTimeNetworkManager.fetchNetwork(searchTerm: "GBP/USD") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let gbpUSD):
                // 데이터(배열)을 받아오고 난 후
                self.gbpUSD = gbpUSD
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        group.enter()
        realTimeNetworkManager.fetchNetwork(searchTerm: "BTC/USD") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let btcUSD):
                // 데이터(배열)을 받아오고 난 후
                self.btcUSD = btcUSD
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        group.enter()
        realTimeNetworkManager.fetchNetwork(searchTerm: "ETH/USD") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let ethUSD):
                // 데이터(배열)을 받아오고 난 후
                self.ethUSD = ethUSD
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
   
        group.notify(queue: .main) { [weak self] in
            let webSocketNetworkView = WebSocketNetworkView(frame: CGRect(x: 0, y: 0, width: Int(self?.view.frame.size.width ?? 0), height: Int((self?.view.frame.size.height ?? 0) * 0.32)))
            self?.setupWebSocket(webSocketNetworkView: webSocketNetworkView)
        }
    }
    
    func setupWebSocket(webSocketNetworkView: WebSocketNetworkView) {
        webSocketNetworkView.appleArray = self.appleArray
        webSocketNetworkView.teslaArray = self.teslaArray
        webSocketNetworkView.microsoftArray = self.microsoftArray
        webSocketNetworkView.nVidiaArray = self.nVidiaArray
        webSocketNetworkView.amazoneArray = self.amazoneArray
        webSocketNetworkView.googleArray = self.googleArray
        
        webSocketNetworkView.eurUSD = self.eurUSD
        webSocketNetworkView.gbpUSD = self.gbpUSD
        webSocketNetworkView.btcUSD = self.btcUSD
        webSocketNetworkView.ethUSD = self.ethUSD
        
        
        webSocketNetworkView.recommendationView.delegate = self
        
        self.tableView.tableHeaderView = webSocketNetworkView
        self.tableView.sectionHeaderTopPadding = 0.0
        self.tableView.reloadData()
    }
    

}


extension FinancialController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.financialNewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsControllerCell.identifier, for: indexPath) as! NewsControllerCell
        
        cell.selectionStyle = .none
        
        cell.newsImage.sd_setImage(with: financialNewsArray[indexPath.row].imageSDURL)
        cell.publisher.text = financialNewsArray[indexPath.row].publisher
        cell.newsTitle.text = financialNewsArray[indexPath.row].headline
        cell.date.text = financialNewsArray[indexPath.row].dateTimeFormatter
        
        
    
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsHeaderView.identifier) as? NewsHeaderView else { return nil }
        
        
        return header
    }
}


extension FinancialController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsUrl = NSURL(string: financialNewsArray[indexPath.row].url)
        let newsSafariView: SFSafariViewController = SFSafariViewController(url: newsUrl! as URL)
        self.present(newsSafariView, animated: true, completion: nil)
    }
}


extension FinancialController: FinancialReloadButtonDelegate {
    func reloadButtonTapped(_ recommendationView: RecommendationView) {
        viewDidLoad()
        self.tableView.reloadData()
    }
    
   
}



