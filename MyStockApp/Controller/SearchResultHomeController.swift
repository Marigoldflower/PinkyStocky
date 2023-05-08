//
//  SearchResultHomeController.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/15.
//

import UIKit


class SearchResultHomeController: UIViewController {

    
    var timer: Timer?
    
    
    var companyManager = CompanyDataManager.shared
    var companyArray: [CompanyDataResult] = []
    
    // 서치바에 적은 글자들이 넘어옴
    var searchTerm: String? {
        didSet {
            setupDatas()
        }
    }
    
    
    let tableView = UITableView()
    
    
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
    
    
    func setupDatas() {
        
        guard let term = searchTerm else { return }
        print("네트워킹 시작 단어 \(term)")
        timer?.invalidate()
        // 타이머를 이용해서 0.3초 내에
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [self] _ in
            companyManager.fetchNetwork(searchTerm: term) { [weak self] result in
                
                switch result {
                case .success(let companyDatas):
                    self?.companyArray = companyDatas
                    // 데이터(배열)을 받아오고 난 후
                    // 테이블 뷰를 다시 그리는 일은 메인 큐에서 일어나야 한다.
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    func setupNav() {
        
        
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
    
    
    func setupSubview() {
        view.addSubview(tableView)
    }
    
    
    
    func setupTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func setupDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    func setupTableView() {
        self.tableView.backgroundColor = .pinkBeige
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
    }
    
    
    
    
    
}


extension SearchResultHomeController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        
        cell.textLabel?.text = companyArray[indexPath.row].codeName
        cell.detailTextLabel?.text = companyArray[indexPath.row].detailName
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}

extension SearchResultHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let companyNewsVC = CompanyNewsController()
        
        
        let navVC = UINavigationController(rootViewController: companyNewsVC)
        companyNewsVC.detailName = companyArray[indexPath.row].detailName
        companyNewsVC.codeName = companyArray[indexPath.row].codeName
        companyNewsVC.searchTerm = companyArray[indexPath.row].codeName
        
        navVC.modalPresentationStyle = .fullScreen
        
        
        // 내비게이션 루트 뷰 컨트롤러 자체를 present 방식으로 넘기면 present로 넘겼는데도 navigation bar를 배치시킬 수 있게 된다.
        present(navVC, animated: true)
        
        
        
        
    }
    
    
}





