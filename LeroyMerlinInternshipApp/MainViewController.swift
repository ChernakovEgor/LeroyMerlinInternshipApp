//
//  MainViewController.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 16.04.2021.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate {

    var collectionView: UICollectionView!
    
    var sections = Section.sections
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reusableIdentifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reusableIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reusableIdentifier)
        
        setupHeader()
        
        collectionView.delegate = self
        
        createDataSource()
        reloadData()
        
        collectionView.contentInset.top = 200
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func setupHeader() {
        headerView = UIView()
        headerView.backgroundColor = .green
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200)
        
        let searchLabel = UILabel()
        searchLabel.text = "Поиск товаров"
        searchLabel.textColor = .white
        searchLabel.textAlignment = .left
        searchLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 32, weight: .bold))
        
        let searchField = UITextField()
        searchField.placeholder = "Поиск"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        
        let barcodeButton = UIButton(type: .roundedRect)
        barcodeButton.backgroundColor = .white
        
        barcodeButton.translatesAutoresizingMaskIntoConstraints = false
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerView)
        headerView.addSubview(searchLabel)
        headerView.addSubview(searchField)
        headerView.addSubview(barcodeButton)

        
        NSLayoutConstraint.activate([
            
            barcodeButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -30),
            barcodeButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            barcodeButton.widthAnchor.constraint(equalToConstant: 40),
            barcodeButton.heightAnchor.constraint(equalTo: barcodeButton.widthAnchor),
            
            searchField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -30),
            searchField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: barcodeButton.leadingAnchor, constant: -20),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            
            
            searchLabel.bottomAnchor.constraint(equalTo: searchField.topAnchor, constant: -10),
            searchLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: -30),
            searchLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
    }
    
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with item: Item, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }

        cell.configure(for: item)
        return cell
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            switch self.sections[indexPath.section].type {
            case "categories":
                return self.configure(CategoryCell.self, with: item, for: indexPath)
            default:
                return self.configure(ItemCell.self, with: item, for: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reusableIdentifier, for: indexPath) as? SectionHeader else {
                return nil
            }
            sectionHeader.titleLabel.text = self?.sections[indexPath.section].title

            return sectionHeader
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]

            switch section.type {
            default:
                return self.createBestSection(using: section)
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createBestSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(150))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(50))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let message = sections[indexPath.section].items[indexPath.row].title
        let ac = UIAlertController(title: "You selected:", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.contentOffset.y
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: -height)
    }
    
    
}
