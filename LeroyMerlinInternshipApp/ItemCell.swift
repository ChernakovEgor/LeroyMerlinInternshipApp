//
//  ItemCell.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 17.04.2021.
//

import UIKit

class ItemCell: UICollectionViewCell, SelfConfiguringCell {
    
    static let reuseIdentifier = "ItemCell"
    
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.numberOfLines = 2
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    func configure(for item: Item) {
        let attributedString = NSMutableAttributedString(string: "\(item.price) ₽/шт.")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: attributedString.length-5))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: NSRange(location: attributedString.length-5, length: 5))
        titleLabel.text = item.title
        priceLabel.attributedText = attributedString
        titleLabel.sizeToFit()
        imageView.image = item.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
