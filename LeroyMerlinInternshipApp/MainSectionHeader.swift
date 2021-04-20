//
//  MainSectionHeader.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 20.04.2021.
//

import UIKit

class MainSectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "MainSectionHeader"
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Dimensions.color
        
        let titleLabel = UILabel()
        titleLabel.text = "Поиск товаров"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        let searchView = UIView()
        searchView.backgroundColor = .white
        searchView.layer.cornerRadius = 5
        
        let barcodeButton = UIButton()
        barcodeButton.backgroundColor = .white
        barcodeButton.tintColor = .black
        barcodeButton.layer.cornerRadius = 5
        barcodeButton.setImage(UIImage(systemName: "barcode"), for: .normal)
        
        let searchButton = UIButton()
        searchButton.tintColor = .white
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
        searchButton.backgroundColor = Dimensions.color

        searchButton.layer.cornerRadius = 3
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        barcodeButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(searchView)
        addSubview(barcodeButton)
        addSubview(searchButton)

        NSLayoutConstraint.activate([
            
            barcodeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            barcodeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            barcodeButton.widthAnchor.constraint(equalToConstant: Dimensions.searchBarHeight),
            barcodeButton.heightAnchor.constraint(equalTo: barcodeButton.widthAnchor),
            
            searchView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            searchView.trailingAnchor.constraint(equalTo: barcodeButton.leadingAnchor, constant: -15),
            searchView.heightAnchor.constraint(equalToConstant: Dimensions.searchBarHeight),
            
            titleLabel.bottomAnchor.constraint(equalTo: searchView.topAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            searchButton.widthAnchor.constraint(equalToConstant: Dimensions.searchBarHeight - 10),
            searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor),
            searchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35),
            searchButton.trailingAnchor.constraint(equalTo: barcodeButton.leadingAnchor, constant: -25),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
