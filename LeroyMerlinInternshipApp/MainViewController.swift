//
//  MainViewController.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 16.04.2021.
//

import UIKit

enum CollectionViewType: Int {
    case catalog = 100
    case limited = 200
    case best = 300
}

class MainViewController: UIViewController {

    var catalogCollectionView: UICollectionView!
    var limitedCollectionView: UICollectionView!
    var bestCollectionView: UICollectionView!
    
    var data = Item.items
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        createCatalogView()
    }
    
    func createCatalogView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        catalogCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        catalogCollectionView.tag = CollectionViewType.catalog.rawValue
        
        catalogCollectionView.translatesAutoresizingMaskIntoConstraints = false
        catalogCollectionView.register(CatalogCell.self, forCellWithReuseIdentifier: "catalogCell")
        
        view.addSubview(catalogCollectionView)
        
        NSLayoutConstraint.activate([
            catalogCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            catalogCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            catalogCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            catalogCollectionView.heightAnchor.constraint(equalTo: catalogCollectionView.widthAnchor, multiplier: 0.7)
        ])
        
        catalogCollectionView.backgroundColor = .white
        
        catalogCollectionView.delegate = self
        catalogCollectionView.dataSource = self
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catalogCell", for: indexPath) as? CatalogCell else { return CatalogCell() }
        cell.data = data[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2.5 - 15, height: view.frame.size.width / 2.5 + 40)
    }
}

class CatalogCell: UICollectionViewCell {
    
    var data: Item? {
        didSet {
            guard let data = data else { return }
            titleLabel.text = data.title
            priceLabel.text = "\(data.price) ₽ / шт."
            imageView.image = data.image
        }
    }
    
    private var titleLabel: UILabel!
    private var priceLabel: UILabel!
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        createTitle()
        createPrice()
        createImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTitle() {
        titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10)
        ])
    }
    
    func createPrice() {
        priceLabel = UILabel()
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .left
        priceLabel.font = priceLabel.font.withSize(20)
        
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -15),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10)
        ])
    }
    
    func createImage() {
        imageView = UIImageView()
    }
}
