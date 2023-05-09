//
//  NewsControllerCell.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/18.
//

import UIKit

class NewsControllerCell: UITableViewCell {
    

    
    static let identifier = "NewsControllerCell"
    
    
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
    
    
    
    private func setConstraints() {
        
        
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        newsImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        newsImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        newsImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        newsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        
        
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackView.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        stackView.topAnchor.constraint(equalTo: newsImage.topAnchor).isActive = true
        
        
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        date.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        date.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor).isActive = true
      

    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
