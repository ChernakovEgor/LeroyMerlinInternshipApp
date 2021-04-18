//
//  ItemCell.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 17.04.2021.
//

import UIKit

class ItemCell: UICollectionViewCell, SelfConfiguringCell {
    
    static let reusableIdentifier = "ItemCell"
    
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        priceLabel.font = priceLabel.font.withSize(20)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //backgroundColor = .red
        
        let stackView = UIStackView(arrangedSubviews: [imageView, priceLabel, titleLabel])
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
        priceLabel.text = "\(item.price) ₽/шт."
        imageView.image = item.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
