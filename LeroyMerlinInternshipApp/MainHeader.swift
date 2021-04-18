//
//  MainHeader.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 18.04.2021.
//

import UIKit

class MainHeader: UICollectionReusableView {
    static let reuseIdentifier = "main"
    
    let titleLabel = UILabel()
    let searchField = UITextField()
    let barcodeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        titleLabel.text = "Поиск товаров"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 32, weight: .bold))
        
        searchField.placeholder = "Поиск"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        
        barcodeButton.backgroundColor = .white
        
        barcodeButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(searchField)
        addSubview(barcodeButton)

        
        NSLayoutConstraint.activate([
            
            barcodeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            barcodeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            barcodeButton.widthAnchor.constraint(equalToConstant: 40),
            barcodeButton.heightAnchor.constraint(equalTo: barcodeButton.widthAnchor),
            
            searchField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: barcodeButton.leadingAnchor, constant: -20),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            
            
            titleLabel.bottomAnchor.constraint(equalTo: searchField.topAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
