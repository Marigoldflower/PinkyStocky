//
//  PanelViewController.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/27.
//

import UIKit
import SDWebImage
import SafariServices


final class CompanyNewsController: UIViewController {
    
    private let finnhubAPIKey = "cficbc9r01qq9nt20eagcficbc9r01qq9nt20eb0"
    private let twelveDataAPIKey = "e94f97bf158743928e4c40929b0e92b7"
    private let newsAPIKey = "317fa039aea64f5383d896dca09a10e6"
    
    
    let DidDismissPostCommentViewController: Notification.Name = Notification.Name("DidDismissPostCommentViewController")
    
    
    let errorView = ErrorView()
    
    let tableView = UITableView()
    
    
    let newsDataNetworkManager = CompanyNewsDataNetworkManager.shared
    var newsDataArray: NewsDataArchive = []
    
    
    let financialMetricsDataMananger = FinancialMetricsDataManager.shared
    var financialMetricsData: Metric?
    
    
    let marketDataNetworkManager = MarketChartDataNetworkManager.shared
    var marketDataArray: [Double] = []
    var sp500MarketDataArray: [Double] = []
    
    
    var searchTerm: String? {
        didSet {
            setupNewsDatas()
        }
    }
    var detailName: String? // 회사의 자세한 이름
    var codeName: String? // AAPL, META
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pinkBeige
        setupCloseButton()
        setupSubview()
        setupTableViewLayout()
        setupDelegate()
        setupTableView()
        setupLoadingView()
        setupNav()
        setupMarketData()
     
    }
    
   
    
    
    private func setupCloseButton() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    
    
    private func setupSubview() {
        
        view.addSubview(tableView)
      
    }
    
    
    
    private func setupTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    
   
    private func setupDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
     
    }
    
    
    
    private func setupTableView() {
        self.tableView.backgroundColor = .pinkBeige
        tableView.register(CompanyNewsCell.self, forCellReuseIdentifier: "CompanyNewsCell")
        tableView.register(CompanyNewsHeaderView.self, forHeaderFooterViewReuseIdentifier: "CompanyNewsHeaderView")
    }
    
   
  
    private func setupLoadingView() {
        let loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.4)))
        self.tableView.tableHeaderView = loadingView
        self.tableView.sectionHeaderTopPadding = 0.0
    }
    
    
    private func setupNewsDatas() {
        
        guard let safeSearchTerm = searchTerm else { return }
        newsDataNetworkManager.fetchNetwork(searchTerm: safeSearchTerm, apiKey: finnhubAPIKey) { result in
            switch result {
            case .success(let newsDatas):
                // 데이터(배열)을 받아오고 난 후
                self.newsDataArray = newsDatas
                // 테이블 뷰를 다시 그리는 일은 메인 큐에서 일어나야 한다.
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                if self.newsDataArray.isEmpty {
                    DispatchQueue.main.async {
                        self.tableView.tableHeaderView = nil
                        self.tableView.backgroundView = self.errorView
                        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
                        self.errorView.goBackButton.addTarget(self, action: #selector(self.goBackButtonTapped), for: .touchUpInside)
                    }
                }
                
            case .failure(let error):
                if self.newsDataArray.isEmpty {
                    DispatchQueue.main.async {
                        self.tableView.tableHeaderView = nil
                        self.tableView.backgroundView = self.errorView
                        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
                        self.errorView.goBackButton.addTarget(self, action: #selector(self.goBackButtonTapped), for: .touchUpInside)
                    }
                }
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func setupMarketData() {
        
        let group = DispatchGroup()
        group.enter()
        
        guard let codeName = codeName else { return }
        
        financialMetricsDataMananger.fetchNetwork(searchTerm: codeName, apiKey: finnhubAPIKey) { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let metricDatas):
                // 데이터(배열)을 받아오고 난 후
                self?.financialMetricsData = metricDatas
                print("DEBUG: metric 데이터 잘 받아왔습니다 \(metricDatas)")
                // 테이블 뷰를 다시 그리는 일은 메인 큐에서 일어나야 한다.
            case .failure(let error):
                print("DEBUG: metric 데이터 오류가 발생했습니다 \(error)")
                
            }
        }
        
        group.enter()
        marketDataNetworkManager.fetchNetwork(searchTerm: codeName, apiKey: finnhubAPIKey) { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let marketData):
                self?.marketDataArray = marketData.close
                print("DEBUG: market 데이터 잘 받아왔습니다 \(marketData.close)")
            case .failure(let error):
                print("DEBUG: market 데이터 오류가 발생했습니다 \(error)")
                print(error.localizedDescription)
            }
        }
        
        
        
        group.notify(queue: .main) {
            let chartsAndDataView = ChartsAndDataView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.4)))
            
            
            if self.newsDataArray.isEmpty {
                self.tableView.tableHeaderView = nil
            } else {
                chartsAndDataView.codeName = self.codeName
                chartsAndDataView.financialMetrics = self.financialMetricsData
                chartsAndDataView.stockResultData = self.marketDataArray
                self.tableView.tableHeaderView = chartsAndDataView
                self.tableView.sectionHeaderTopPadding = 0.0
            }
        }

    }
    
    
    private func setupNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // 내비게이션 바 투명하지 않게
        appearance.backgroundColor = .autumnPink    // 내비게이션 바 색상설정
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.white]
        

       
        // 내비게이션 바 버튼 색깔 설정 (< 이전으로 같은 버튼)
        navigationController?.navigationBar.tintColor = .tintPink
        navigationController?.navigationBar.topItem?.title = detailName
        
        // 내비게이션 바 Safe Area까지 꽉 차게 만들기
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        
    }

    
    @objc private func goBackButtonTapped() {
        self.dismiss(animated: true)
    }
    
    
}




extension CompanyNewsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyNewsCell", for: indexPath) as! CompanyNewsCell

        // 셀을 클릭할 때 아무런 색깔의 변화도 없게 만드는 코드
        cell.selectionStyle = .none
        cell.newsImage.sd_setImage(with: newsDataArray[indexPath.row].imageSDURL)
        cell.publisher.text = newsDataArray[indexPath.row].publisher
        cell.newsTitle.text = newsDataArray[indexPath.row].newsTitle
        cell.date.text = newsDataArray[indexPath.row].dateTimeString

        return cell
        
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 130
     }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 80
    }
    
}




extension CompanyNewsController: UITableViewDelegate {
    
    // 뉴스 기사를 클릭하면 SafariController를 통해 기사 원문으로 넘어가도록 해야 함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsUrl = NSURL(string: newsDataArray[indexPath.row].url)
        let newsSafariView: SFSafariViewController = SFSafariViewController(url: newsUrl! as URL)
        self.present(newsSafariView, animated: true, completion: nil)
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        // header의 UI를 처리하는 것을 여기서 해도 괜찮다! ⭐️⭐️
        // 예를 들면 header의 버튼을 없앤다든지, header의 text 크기를 더 크게 만든다든지 등등.
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CompanyNewsHeaderView") as? CompanyNewsHeaderView else { return nil }
        
        if self.newsDataArray.isEmpty {
            return nil
            
        } else {
            header.headerText.text = codeName
            header.delegate = self
        }
        
        
        for stock in UserDefaults.standard.userDataList {
            if stock.codeName == header.headerText.text {
                header.addToMyStockList.isHidden = true
            }
        }
        
        
        return header
    }

}


extension CompanyNewsController: AddStockListButtonDelegate {
    func addStockListButtonTapped(_ header: CompanyNewsHeaderView) {
        let alert = UIAlertController(title: "Add to my stock list", message: "Would you like to add this stock to my stock list?", preferredStyle: .alert)
       
        let success = UIAlertAction(title: "Yes", style: .default) { action in
            
            let homeVC = HomeController()
            
            guard let codeName = self.codeName else { return }
            guard let detailName = self.detailName else { return }
        
            let todayPriceLabel = round(self.marketDataArray[self.marketDataArray.endIndex - 1] * 100) / 100 
            let yesterdayPriceLabel = round(self.marketDataArray[self.marketDataArray.endIndex - 2] * 100) / 100
            let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
            
            let newStock = MyStockList(codeName: codeName, detailName: detailName, priceLabel: "\(todayPriceLabel)", changeLabel: changeLabel, chartData: self.marketDataArray)
            UserDefaults.standard.userDataList.append(newStock)
            
            
            NotificationCenter.default.post(name: self.DidDismissPostCommentViewController, object: nil, userInfo: nil)
            
            self.dismiss(animated: true)
            
            
            
        }
                
        let cancel = UIAlertAction(title: "No", style: .cancel) { cancel in
            print("취소 버튼이 눌렸습니다")
        }
                
                
        alert.addAction(cancel)
        alert.addAction(success)
                        
        present(alert, animated: true, completion: nil)
    }
    
    
}



