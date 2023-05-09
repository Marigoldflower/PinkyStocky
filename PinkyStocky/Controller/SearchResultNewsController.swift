//
//  SearchResultNewsController.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/21.
//

import UIKit
import SafariServices

class SearchResultNewsController: UIViewController {

    var timer: Timer?
    
    let errorView = ErrorView()
    
    var companyNewsDataNetworkManager = CompanyNewsDataNetworkManager.shared
    var companyNewsDataArray: NewsDataArchive = []
    
    let tableView = UITableView()
    
    var searchTerm: String? {
        didSet {
            setupDatas()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupSubview()
        setupTableViewLayout()
        setupDelegate()
        setupTableView()
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
    
    
    private func setupDatas() {
        
        guard let term = searchTerm else { return }
        print("네트워킹 시작 단어 \(term)")
        timer?.invalidate()
        // 타이머를 이용해서 0.3초 내에 네트워킹 작업이 이루어질 수 있도록
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [self] _ in
            companyNewsDataNetworkManager.fetchNetwork(searchTerm: term) { result in
                
                switch result {
                case .success(let companyDatas):
                    self.companyNewsDataArray = companyDatas
                    // 데이터(배열)을 받아오고 난 후
                    // 테이블 뷰를 다시 그리는 일은 메인 큐에서 일어나야 한다.
                    DispatchQueue.main.async {
                        self.tableView.reloadData() 
                    }
                   
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    private func setupNav() {
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 내비게이션 바 투명하지 않게
        appearance.backgroundColor = .pinkBeige     // 내비게이션 바 색상설정
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        
        // 내비게이션 바 버튼 색깔 설정 (< 이전으로 같은 버튼)
        navigationController?.navigationBar.tintColor = .tintPink
        
        
        
        
        // 내비게이션 바 Safe Area까지 꽉 차게 만들기
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        
        // 내비게이션 바 타이틀 설정
        
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
        tableView.register(SearchResultNewsCell.self, forCellReuseIdentifier: SearchResultNewsCell.identifier)
    }


}

extension SearchResultNewsController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyNewsDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultNewsCell.identifier, for: indexPath) as! SearchResultNewsCell
        
        cell.publisher.text = companyNewsDataArray[indexPath.row].publisher
        cell.newsTitle.text = companyNewsDataArray[indexPath.row].newsTitle
        cell.date.text = companyNewsDataArray[indexPath.row].dateTimeString
        cell.newsImage.sd_setImage(with: companyNewsDataArray[indexPath.row].imageSDURL)
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
 
extension SearchResultNewsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsUrl = NSURL(string: companyNewsDataArray[indexPath.row].url)
        let newsSafariView: SFSafariViewController = SFSafariViewController(url: newsUrl! as URL)
        self.present(newsSafariView, animated: true, completion: nil)
        
    }
    
    
}






