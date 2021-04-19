//
//  CategoryCell.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 18.04.2021.
//

import UIKit

class CategoryCell: UICollectionViewCell, SelfConfiguringCell {
    static var reusableIdentifier = "CategoryCell"
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(for item: Item) {
        titleLabel.text = item.title
    
        let width = contentView.frame.size.width
        
        if item.title == "Каталог" {
            backgroundColor = Dimensions.color
            titleLabel.textColor = .white
            imageView.image = UIImage(systemName: "list.dash")
            imageView.tintColor = .white
            
            imageView.frame = CGRect(x: width / 2, y: width / 2, width: width / 2, height: width / 2)
        } else if item.title == "Смотреть всё" {
            backgroundColor = .systemGray6
            titleLabel.textColor = .black
            titleLabel.sizeToFit()
            imageView.image = UIImage(systemName: "arrow.right.circle")
            imageView.tintColor = Dimensions.color
            
            imageView.frame = CGRect(x: width / 3, y: width / 2.5, width: width / 3 , height: width / 3 )
        } else {
            backgroundColor = .systemGray6
            titleLabel.textColor = .black
            titleLabel.sizeToFit()
            imageView.image = item.image
            imageView.tintColor = .none
            
            imageView.frame = CGRect(x: width / 3, y: width / 3, width: width , height: width )
            let maskView = UIView(frame: CGRect(x: 0, y: 0, width: width * 2 / 3, height: width * 2 / 3))
            maskView.layer.cornerRadius = layer.cornerRadius
            maskView.backgroundColor = .blue
            imageView.mask = maskView
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
