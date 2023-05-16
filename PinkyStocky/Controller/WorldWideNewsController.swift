//
//  WallStreetJournalController.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/24.
//

import UIKit
import SDWebImage
import SafariServices

class WorldWideNewsController: UIViewController {
    
    private let finnhubAPIKey = "cficbc9r01qq9nt20eagcficbc9r01qq9nt20eb0"
    private let twelveDataAPIKey = "e94f97bf158743928e4c40929b0e92b7"
    private let newsAPIKey = "317fa039aea64f5383d896dca09a10e6"

    let searchController = UISearchController(searchResultsController: SearchResultNewsController())
    
    
    let tableView = UITableView()
    
    
    var worldWideNewsNetworkManager = WorldWideNewsDataNetworkManager.shared
    var worldWideNewsArray: [WorldWideNewsData] = []
    
    var topNewsNetworkManager = TopNewsDataNetworkManager.shared
    var topNewsArray: [TopNewsData] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupSearchController()
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
        navigationItem.title = "World Wide News"
    }
    
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        
        // 🍎 서치(결과)컨트롤러의 사용 (복잡한 구현 가능)
        //     ==> 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self
        
        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
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
        let loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height * 0.33)))
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
        self.tableView.register(WorldWideNewsCell.self, forCellReuseIdentifier: WorldWideNewsCell.identifier)
        self.tableView.register(WorldWideNewsHeaderView.self, forHeaderFooterViewReuseIdentifier: WorldWideNewsHeaderView.identifier)
    }
    
    
    private func setupDatas() {
        let group = DispatchGroup()
        group.enter()
        
        worldWideNewsNetworkManager.fetchNetwork(searchTerm: "business", apiKey: newsAPIKey) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let worldNews):
                // 데이터(배열)을 받아오고 난 후
                self.worldWideNewsArray = worldNews
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.enter()
        topNewsNetworkManager.fetchNetwork(searchTerm: "techcrunch", apiKey: newsAPIKey) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let topNewsDatas):
                // 데이터(배열)을 받아오고 난 후
                self.topNewsArray = topNewsDatas
                // 테이블 뷰를 다시 그리는 일은 메인 큐에서 일어나야 한다.
                print("현재 값이 들어온 상태입니다!! \(self.topNewsArray.count)")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            let topNewsView = WorldWideTopNewsView(frame: CGRect(x: 0, y: 0, width: Int(self?.view.frame.size.width ?? 0), height: Int((self?.view.frame.size.height ?? 0) * 0.4)))
            self?.setupWorldWideNews(topNewsView: topNewsView)
        }
    }
    
    func setupWorldWideNews(topNewsView: WorldWideTopNewsView) {
        topNewsView.topNewsCollection = self.topNewsArray
        topNewsView.delegate = self
        self.tableView.tableHeaderView = topNewsView
        self.tableView.sectionHeaderTopPadding = 0.0
    }
    
}


extension WorldWideNewsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.worldWideNewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorldWideNewsCell.identifier, for: indexPath) as! WorldWideNewsCell
        
        cell.journalImage.sd_setImage(with: worldWideNewsArray[indexPath.row].imageSDURL)
        cell.journalTitle.text = worldWideNewsArray[indexPath.row].newsTitle
        cell.journalDescription.text = worldWideNewsArray[indexPath.row].newsDescription
        cell.author.text = worldWideNewsArray[indexPath.row].author
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: WorldWideNewsHeaderView.identifier) as? WorldWideNewsHeaderView else { return nil }
        
        
        return header
    }
    
    
    
    
    
}


extension WorldWideNewsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsUrl = NSURL(string: worldWideNewsArray[indexPath.row].url)
        let newsSafariView: SFSafariViewController = SFSafariViewController(url: newsUrl! as URL)
        self.present(newsSafariView, animated: true, completion: nil)
    }
}




extension WorldWideNewsController: TopNewsDelegate {
    func topNewsTapped(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsUrl = NSURL(string: topNewsArray[indexPath.row].url)
        let newsSafariView: SFSafariViewController = SFSafariViewController(url: newsUrl! as URL)
        self.present(newsSafariView, animated: true, completion: nil)
    }
    
}



extension WorldWideNewsController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search world wide news...☺️", attributes: [NSAttributedString.Key.foregroundColor : UIColor.headerPink, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        // 글자를 치는 순간에 다른 화면을 보여주고 싶다면 (컬렉션뷰를 보여줌)
        let vc = searchController.searchResultsController as! SearchResultNewsController
        // 컬렉션뷰에 찾으려는 단어 전달
        // SearchResultController에 반드시 searchTerm 변수가 존재해야 한다.
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}
