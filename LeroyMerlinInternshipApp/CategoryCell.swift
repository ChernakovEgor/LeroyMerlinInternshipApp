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
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //backgroundColor = .red
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.7).isActive = true
    }
    
    func configure(for item: Item) {
        titleLabel.text = item.title
        imageView.image = item.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
