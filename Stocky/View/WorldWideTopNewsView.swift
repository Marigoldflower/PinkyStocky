//
//  TopNewsView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/18.
//

import UIKit
import SDWebImage
import SafariServices




protocol TopNewsDelegate: AnyObject {
    func topNewsTapped(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

// 이 뷰 안에 delegate = self가 있어야 함
class WorldWideTopNewsView: UIView {
    
    
    weak var delegate: TopNewsDelegate?
    
    // 뷰 컨트롤러에서 네트워크 통신을 거쳐서 데이터가 담긴 배열을 받기 위한 변수
    var topNewsCollection: [TopNewsData]? {
        didSet {
            print("topNewsCollection에 값이 담겼습니다 \(topNewsCollection?.count)")
        }
    }
    
    
    let collectionView: UICollectionView = {
         let flowLayout = UICollectionViewFlowLayout()
         flowLayout.scrollDirection = .horizontal // 가로로 컬렉션 뷰 생성
         flowLayout.minimumInteritemSpacing = 40 // 아이템 사이 간격 설정
         flowLayout.minimumLineSpacing = 40 // 아이템 위 아래 간격 설정
             // ⭐️ 코드로 컬렉션 뷰를 생성할 때에는 반드시 파라미터가 존재해야 한다. ⭐️
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .pinkBeige
         return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        setupLayout()
        setupDelegate()
        registerCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    func setupLayout() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
    }
    
    
    func setupDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    func registerCollectionView() {
        collectionView.register(WorldWideTopNewsCell.self, forCellWithReuseIdentifier: WorldWideTopNewsCell.identifier)
    }

  
    
    
}


extension WorldWideTopNewsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let topNewsCollection = topNewsCollection else { fatalError() }
        return topNewsCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let topNewsCollection = topNewsCollection else { fatalError() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorldWideTopNewsCell.identifier, for: indexPath) as! WorldWideTopNewsCell
        cell.topNewsImageView.sd_setImage(with: topNewsCollection[indexPath.item].imageSDURL)
        cell.topNewsTitle.text = topNewsCollection[indexPath.item].newsTitle
        cell.topNewsDescription.text = topNewsCollection[indexPath.item].author
        
        return cell
   
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
}


extension WorldWideTopNewsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.topNewsTapped(collectionView, didSelectItemAt: indexPath)
    }
}


extension WorldWideTopNewsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: self.frame.size.height)
    }
}


