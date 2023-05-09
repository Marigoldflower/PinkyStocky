//
//  ViewController.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/15.
//

import UIKit
import Charts


class HomeController: UIViewController {
    
    
    lazy var errorView = ErrorView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.28)))
    
    
    var userDefaultsCount = UserDefaults.standard.userDataList.count - 1
    
    
    let sp500ChartsView = SP500ChartsView()
    
    
    let loadingView = LoadingView()
    let guideTextView = GuideTextView()
    var tableView = UITableView()

    let searchController = UISearchController(searchResultsController: SearchResultHomeController())
    
    
    var marketChartDataNetworkManager = MarketChartDataNetworkManager.shared
    var sp500MarketDataArray: [Double] = []
    
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRefresh()
        setupNav()
        setupSubview()
        setupTableViewLayout()
        setupDelegate()
        setupLoadingView()
        setupMarketData()
        setupInitial()
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
    
   
    
    
    private func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        
        refreshControl.backgroundColor = .pinkBeige
        refreshControl.tintColor = .tintPink

        
        tableView.refreshControl = refreshControl
    }
    
    
    private func setupInitial() {
        if !UserDefaults.standard.userDataList.isEmpty {
            setupUpdatingUserDefaults(index: userDefaultsCount)
        }
    }
    
    private func setupNav() {
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 내비게이션 바 투명하지 않게
        appearance.backgroundColor = .pinkBeige    // 내비게이션 바 색상설정
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()

        navigationController?.navigationBar.tintColor = .tintPink
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance

    
        navigationItem.title = "Stock"
    }
    
    
    private func setupSubview() {
        view.addSubview(tableView)
    }
    
    
    
    private func setupTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    
    
    private func setupDelegate() {
        tableView.dataSource = self
        tableView.delegate = self

        
    }
    
    
    
    private func setupLoadingView() {
        self.tableView.tableHeaderView = LoadingView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.28)))
        
    }
    
    
    private func setupMarketData() {
        
        let group = DispatchGroup()
        
        group.enter()
        marketChartDataNetworkManager.fetchNetwork(searchTerm: "SPY") { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let spMarketData):
                // 데이터(배열)을 받아오고 난 후
                self?.sp500MarketDataArray = spMarketData.close
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            if self.sp500MarketDataArray.isEmpty {
                print("S&P500에 값이 존재하지 않습니다!")
                self.errorView.goBackButton.setTitle("Reload?", for: .normal)
                self.errorView.goBackButton.addTarget(self, action: #selector(self.didSelectReload), for: .touchUpInside)
                self.tableView.tableHeaderView = self.errorView
                return
            }
            let sp500ChartsView = SP500ChartsView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.28)))
            sp500ChartsView.marketResultData = self.sp500MarketDataArray
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
    
    
    @objc func didSelectReload() {
        viewDidLoad()
        self.tableView.reloadData()
    }
    
    
    
    private func setupUpdatingUserDefaults(index: Int) {
        // UserDefaults에 2개의 객체가 저장되어 있다면 배열에는 1개로 표현되어야 한다.
        // 왜냐하면 배열은 0, 1로 객체를 세지만, 일반적으로는 1, 2로 객체를 세기 때문이다.
        for number in 0...index {
            print("지금 들어온 수는 \(number)임")
            marketChartDataNetworkManager.fetchNetwork(searchTerm: UserDefaults.standard.userDataList[number].codeName) { result in
                switch result {
                case .success(let data):
                    let codeName = UserDefaults.standard.userDataList[number].codeName
                    let detailName = UserDefaults.standard.userDataList[number].detailName
                    let todayPriceLabel = round(data.close[data.close.endIndex - 1] * 100) / 100
                    let yesterdayPriceLabel = round(data.close[data.close.endIndex - 2] * 100) / 100
                    let changeLabel = round((todayPriceLabel - yesterdayPriceLabel) * 100) / 100
                    
                    let newStock = MyStockList(codeName: codeName, detailName: detailName, priceLabel: "\(todayPriceLabel)", changeLabel: changeLabel, chartData: data.close)
                    UserDefaults.standard.userDataList[number] = newStock
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    

    private func setupTableView() {
        self.tableView.backgroundColor = .pinkBeige
        tableView.register(HomeControllerCell.self, forCellReuseIdentifier: "HomeControllerCell")
        tableView.register(HomeControllerHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeControllerHeaderView.identifier)

    }
    
    
    private func setupSearchController() {
        
        
        // 내비게이션 바에 서치(결과) 컨트롤러 생성
        navigationItem.searchController = searchController
        
        // 🍎 서치(결과)컨트롤러의 사용 (복잡한 구현 가능)
        //     ==> 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self
        
        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }
    
    private func setupNotification() {
        let companyNewsController = CompanyNewsController()
        NotificationCenter.default.addObserver(self, selector: #selector(self.didDismissPostCommentNotification(_:)), name: companyNewsController.DidDismissPostCommentViewController, object: nil)
        
        
    }
    
    @objc private func didDismissPostCommentNotification(_ noti: Notification) {
     
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.userDefaultsCount = UserDefaults.standard.userDataList.count - 1
            
        }
    }
    
    
    
    @objc private func refreshTable(refresh: UIRefreshControl) {
        print("새로고침 시작")
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.viewDidLoad()
            refresh.endRefreshing()
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

        
        cell.stockChartsView.marketResultData = UserDefaults.standard.userDataList[indexPath.row].chartData
        cell.stockChartsView.chartView.legend.enabled = false
        cell.stockChartsView.chartView.rightAxis.enabled = false
        cell.stockChartsView.chartView.setScaleEnabled(false)
        cell.stockChartsView.backgroundColor = .pinkBeige
        
  
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                UserDefaults.standard.userDataList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.userDefaultsCount -= 1
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
        self.tableView.reloadData()
    }
}



extension HomeController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search stock name or stock symbol..☺️", attributes: [NSAttributedString.Key.foregroundColor : UIColor.headerPink, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        
        let vc = searchController.searchResultsController as! SearchResultHomeController
        // 서치바에 적은 단어들을 SearchResultController에 전달함
        vc.searchTerm = searchController.searchBar.text ?? ""
        
    }
    
 
    
}





