//
//  SearchResultDetailCell.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/16.
//

import UIKit

class CompanyNewsCell: UITableViewCell {
    
    
//    var imageUrl: String? {
//         didSet {
//            loadImage()
//         }
//    }

    
    
    
    // MARK: - 뉴스기사 관련 요소들
    
    let publisher: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    
    let newsTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.numberOfLines = 3
        return label
    }()
    
    
    let date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    
    
    // MARK: - 뉴스 이미지
    
    let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    
    
    
    
    // MARK: - 스택 뷰
    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [publisher, newsTitle])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
   
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(stackView)
        self.addSubview(newsImage)
        self.addSubview(date)
        
    }
    
    
    
    override func updateConstraints() {
         setConstraints() // 오토레이아웃 관련 코드
         super.updateConstraints()
    }
    
    
    
    func setConstraints() {
        
        
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        newsImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        newsImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        newsImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        newsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        
        
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackView.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: newsImage.topAnchor).isActive = true
        
        
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        date.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        date.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor).isActive = true
      

    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//
//    func loadImage() {
//        guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
//
//        // 오래걸리는 작업을 동시성 처리 (다른 쓰레드에서 일시킴)
//        DispatchQueue.global().async {
//            // URL을 가지고 데이터를 만드는 메서드 (오래걸리는데 동기적인 실행)
//            // (일반적으로 이미지를 가져올때 많이 사용)
//            guard let data = try? Data(contentsOf: url) else { return }
//            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
//            guard urlString == url.absoluteString else { return }
//
//            // 데이터 작업의 결과물을 @IBOutlet 이미지 뷰에 할당 (메인큐)
//            DispatchQueue.main.async {
//                self.newsImage.image = UIImage(data: data)
//            }
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
