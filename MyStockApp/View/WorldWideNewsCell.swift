//
//  BookCell.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/23.
//

import UIKit

class WorldWideNewsCell: UITableViewCell {

    
    static let identifier = "NewYorkTimesJournalCell"
    
    
    
    var imageUrl: String? {
         didSet {
            loadImage()
         }
    }


    
    
    // MARK: - 책 정보
    
    
    
    let journalTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.numberOfLines = 2
        return label
    }()
    
    
    let date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    
    let journalDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    
    // MARK: - 책 이미지
    
    let journalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    
    
    
    // MARK: - 스택 뷰
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [journalTitle, date])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(stackView)
        self.addSubview(journalDescription)
        self.addSubview(journalImage)
        setConstraints()
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func loadImage() {
        print("urlString 값 시작합니다")
         guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
        print("urlString 값 제대로 처리됐나요? \(urlString)예쓰!!!")
         // 오래걸리는 작업을 동시성 처리 (다른 쓰레드에서 일시킴)
         DispatchQueue.global().async {
             // URL을 가지고 데이터를 만드는 메서드 (오래걸리는데 동기적인 실행)
             // (일반적으로 이미지를 가져올때 많이 사용)
             guard let data = try? Data(contentsOf: url) else { return }
             // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
             guard urlString == url.absoluteString else { return }
                
             // 데이터 작업의 결과물을 @IBOutlet 이미지 뷰에 할당 (메인큐)
             DispatchQueue.main.async {
                 self.journalImage.image = UIImage(data: data)
             }
          }
    }
    
    
    
    func setConstraints() {
        journalImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        journalImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        journalImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        journalImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        journalImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        journalImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        
        
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackView.leadingAnchor.constraint(equalTo: journalImage.trailingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: journalImage.topAnchor).isActive = true
        
        
        
        journalDescription.translatesAutoresizingMaskIntoConstraints = false
        
        journalDescription.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        journalDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        journalDescription.bottomAnchor.constraint(equalTo: journalImage.bottomAnchor).isActive = true
    }
    
    
    
    
}
