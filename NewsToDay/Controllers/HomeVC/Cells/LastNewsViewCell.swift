//
//  LastNewsViewCell.swift
//  NewsToDay
//
//  Created by mac on 5/9/23.
//

import UIKit
import SnapKit

class LastNewsViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.blackPrimary
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.blackPrimary
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let imageBookmark: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bookmark")
        image.tintColor = Resources.Colors.blackDark
        return image
    }()
    
    // MARK: - init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupView() {
        backgroundColor = .systemGray
        layer.cornerRadius = 16
    }
    
    func configureCell(article: Source) {
        titleLabel.text = article.name
        categoryLabel.text = article.category
        
    }
    
    func fetchImage(image: Article) {
        DispatchQueue.global().async {
            guard let stringUrl = image.urlToImage else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
        
    }
}

// MARK: - Extention, setup constraints

extension LastNewsViewCell {
    
    private func setupConstraints() {
        
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        addSubview(imageBookmark)
        imageBookmark.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
