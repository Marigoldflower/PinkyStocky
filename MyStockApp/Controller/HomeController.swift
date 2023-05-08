//
//  ViewController.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/15.
//

import UIKit
import Charts


class HomeController: UIViewController {
    
    
    let sp500ChartsView = SP500ChartsView()
    
    
    let loadingView = LoadingView()
    let guideTextView = GuideTextView()
    var tableView = UITableView()

    let searchController = UISearchController(searchResultsController: SearchResultHomeController())
    
    
    var marketChartDataNetworkManager = MarketChartDataNetworkManager.shared
    var sp500MarketDataArray: [Double]? = [] {
        didSet {
            guard let sp500MarketDataArray = sp500MarketDataArray else { return }
            print("S&P500에 값이 들어왔습니다!!!! \(sp500MarketDataArray.count)")
        }
    }
    
    var updatedStock: [Double] = [] {
        didSet {
            print("새로운 주식으로 업데이트 되었습니다. \(updatedStock.count)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupSubview()
        setupTableViewLayout()
        setupDelegate()
        setupLoadingView()
        setupMarketData()
        setupTableView()
        setupSearchController()
        setupNotification()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
            
            
        }
    }
    
    
    func setupNav() {
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 내비게이션 바 투명하지 않게
        appearance.backgroundColor = .pinkBeige    // 내비게이션 바 색상설정
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()

        navigationController?.navigationBar.tintColor = .tintPink
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.prefersLargeTitles = true
    
        navigationItem.title = "Stock"
    }
    
    
    func setupSubview() {
        view.addSubview(tableView)
    }
    
    
    
    func setupTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    
    
    func setupDelegate() {
        tableView.dataSource = self
        tableView.delegate = self

        
    }
    
    
    
    func setupLoadingView() {
        self.tableView.tableHeaderView = LoadingView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.28)))
        
    }
    
    
    func setupMarketData() {
        let group = DispatchGroup()
        
        group.enter()
        marketChartDataNetworkManager.fetchNetwork(searchTerm: "SPY") { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let spMarketData):
                // 데이터(배열)을 받아오고 난 후
                self.sp500MarketDataArray = spMarketData.close
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            guard let sp500MarketDataArray = self.sp500MarketDataArray else {
                let errorView = ErrorView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.28)))
                errorView.goBackButton.isHidden = true
                errorView.emptyLabel.font = .boldSystemFont(ofSize: 14)
                self.tableView.tableHeaderView = errorView
                return
            }
            let sp500ChartsView = SP500ChartsView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.28)))
            sp500ChartsView.marketResultData = self.sp500MarketDataArray ?? []
            sp500ChartsView.delegate = self
            
           
            
            let todayPriceLabel = round(sp500ChartsView.marketResultData[sp500ChartsView.marketResultData.endIndex - 1] * 100) / 100
            let yesterdayPriceLabel = round(sp500ChartsView.marketResultData[sp500ChartsView.marketResultData.endIndex - 2] * 100) / 100
            let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
            
            
            if changeLabel < 0 {
                sp500ChartsView.changeLabel.backgroundColor = .autumnBlue
                sp500ChartsView.changeLabel.text = "\(changeLabel)"
            } else {
                sp500ChartsView.changeLabel.backgroundColor = .autumnPink
                sp500ChartsView.changeLabel.text = "\(changeLabel)"
            }
            self.tableView.tableHeaderView = sp500ChartsView

        }
    }
    

    
    func setupTableView() {
        self.tableView.backgroundColor = .pinkBeige
        tableView.register(HomeControllerCell.self, forCellReuseIdentifier: "HomeControllerCell")
        tableView.register(HomeControllerHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeControllerHeaderView.identifier)

    }
    
    
    func setupSearchController() {
        
        
        // 내비게이션 바에 서치(결과) 컨트롤러 생성
        navigationItem.searchController = searchController
        
        // 🍎 서치(결과)컨트롤러의 사용 (복잡한 구현 가능)
        //     ==> 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self
        
        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }
    
    func setupNotification() {
        let companyNewsController = CompanyNewsController()
        NotificationCenter.default.addObserver(self, selector: #selector(self.didDismissPostCommentNotification(_:)), name: companyNewsController.DidDismissPostCommentViewController, object: nil)
        
        
    }
    
    @objc func didDismissPostCommentNotification(_ noti: Notification) {
     
        DispatchQueue.main.async {
            self.tableView.reloadData()
        } 
    }
    
    
    
   
    
}


extension HomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if UserDefaults.standard.userDataList.isEmpty {
            self.tableView.backgroundView = self.guideTextView
        } else {
            self.tableView.clearBackground()
        }
        
        return UserDefaults.standard.userDataList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeControllerCell", for: indexPath) as! HomeControllerCell
        
        // 셀을 클릭할 때 아무런 색깔의 변화도 없게 만드는 코드
        cell.selectionStyle = .none
        
        cell.codeName.text = UserDefaults.standard.userDataList[indexPath.row].codeName
        cell.detailName.text = UserDefaults.standard.userDataList[indexPath.row].detailName
        cell.priceLabel.text = UserDefaults.standard.userDataList[indexPath.row].priceLabel
        
        
        if UserDefaults.standard.userDataList[indexPath.row].changeLabel < 0 {
            cell.changeLabel.backgroundColor = .autumnBlue
            cell.changeLabel.text = String(UserDefaults.standard.userDataList[indexPath.row].changeLabel)
        } else {
            cell.changeLabel.backgroundColor = .autumnPink
            cell.changeLabel.text = String(UserDefaults.standard.userDataList[indexPath.row].changeLabel)
        }

        let newView = StockChartsView(frame: CGRectMake(192, 10, 138, 55))
        newView.marketResultData = UserDefaults.standard.userDataList[indexPath.row].chartData
        newView.chartView.legend.enabled = false
        newView.chartView.rightAxis.enabled = false
        newView.chartView.setScaleEnabled(false)
        newView.backgroundColor = .pinkBeige
        cell.contentView.addSubview(newView)
        
        
        
  
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                UserDefaults.standard.userDataList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            }
                let pointConfiguration = UIImage.SymbolConfiguration(pointSize: 13.5)
                deleteAction.image = UIImage(systemName: "trash", withConfiguration: pointConfiguration)
                deleteAction.backgroundColor = .tintPink
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 1
    }
    
   
    
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let companyNewsVC = CompanyNewsController()
        
        let navVC = UINavigationController(rootViewController: companyNewsVC)
        
        let codeName = UserDefaults.standard.userDataList[indexPath.row].codeName
        let detailName = UserDefaults.standard.userDataList[indexPath.row].detailName
        
        companyNewsVC.detailName = detailName
        companyNewsVC.codeName = codeName
        companyNewsVC.searchTerm = codeName
        
        
        navVC.modalPresentationStyle = .fullScreen
        
        // 내비게이션 루트 뷰 컨트롤러 자체를 present 방식으로 넘기면 present로 넘겼는데도 navigation bar를 배치시킬 수 있게 된다.
        present(navVC, animated: true)
        
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // header의 UI를 처리하는 것을 여기서 해도 괜찮다! ⭐️⭐️
        // 예를 들면 header의 버튼을 없앤다든지, header의 text 크기를 더 크게 만든다든지 등등.

        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeControllerHeaderView.identifier) as? HomeControllerHeaderView else { return nil }

        return header
    }
}


extension HomeController: ReloadButtonDelegate {
    func reloadButtonTapped(_ sp500ChartsView: SP500ChartsView) {
        viewDidLoad()
        let companyNewsController = CompanyNewsController()
        companyNewsController.viewDidLoad()
        self.tableView.reloadData()
        
    }
}



extension HomeController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter stock name or stock symbol...☺️", attributes: [NSAttributedString.Key.foregroundColor : UIColor.headerPink, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        
        let vc = searchController.searchResultsController as! SearchResultHomeController
        // 서치바에 적은 단어들을 SearchResultController에 전달함
        vc.searchTerm = searchController.searchBar.text ?? ""
        
    }
    
 
    
}





