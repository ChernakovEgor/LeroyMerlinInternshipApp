//
//  MainViewController.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 16.04.2021.
//

import UIKit

//Constants used for UI adjustments
struct Dimensions {
    static let searchBarHeight: CGFloat = 45
    static let color = UIColor(red: 83.0/255.0, green: 210.0/255.0, blue: 64.0/255.0, alpha: 1)
    static let scrollInset: CGFloat = 220
}


class MainViewController: UIViewController {

    var collectionView: UICollectionView!
    
    var sections = Section.sections
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    var headerView: UIView!
    var headerViewHeightAnchor: NSLayoutConstraint!
    
    var lastOffset: CGFloat = -Dimensions.scrollInset - 20
    
    var searchBar: UITextField!
    var searchBarLeadingAnchor: NSLayoutConstraint!
    var searchBarBottomAnchor: NSLayoutConstraint!
    var searchBarTopAnchor: NSLayoutConstraint!
    var searchBarTrailingAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeader()
        setupSearchField()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reusableIdentifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reusableIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reusableIdentifier)
        collectionView.register(SectionFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooter.reuseIdentifier)
        
        collectionView.delegate = self
        
        createDataSource()
        reloadData()
        
        collectionView.contentInset.top = Dimensions.scrollInset
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupHeader() {
        headerView = UIView()
        headerView.backgroundColor = .green
        headerView.backgroundColor = Dimensions.color
        headerView.layer.zPosition = 10
        
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
        headerView.translatesAutoresizingMaskIntoConstraints = false
        barcodeButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(searchView)
        headerView.addSubview(barcodeButton)
        headerView.addSubview(searchButton)

        headerViewHeightAnchor = headerView.heightAnchor.constraint(equalToConstant: Dimensions.scrollInset)
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerViewHeightAnchor,
            
            barcodeButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -30),
            barcodeButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            barcodeButton.widthAnchor.constraint(equalToConstant: Dimensions.searchBarHeight),
            barcodeButton.heightAnchor.constraint(equalTo: barcodeButton.widthAnchor),
            
            searchView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -30),
            searchView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            searchView.trailingAnchor.constraint(equalTo: barcodeButton.leadingAnchor, constant: -15),
            searchView.heightAnchor.constraint(equalToConstant: Dimensions.searchBarHeight),
            
            titleLabel.bottomAnchor.constraint(equalTo: searchView.topAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: -30),
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            searchButton.widthAnchor.constraint(equalToConstant: Dimensions.searchBarHeight - 10),
            searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor),
            searchButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -35),
            searchButton.trailingAnchor.constraint(equalTo: barcodeButton.leadingAnchor, constant: -25),
        ])
    }
    
    func setupSearchField() {
        searchBar = UITextField()
        searchBar.placeholder = "  Поиск"
        searchBar.layer.cornerRadius = 5
        searchBar.backgroundColor = .white
        
        searchBar.layer.shadowColor = UIColor.black.cgColor
        
        searchBar.layer.shadowRadius = 0
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        
        searchBar.layer.zPosition = 20
        
        let padding = UIView()
        padding.backgroundColor = .white
        padding.layer.zPosition = 5
        padding.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20 + Dimensions.searchBarHeight)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(padding)
        view.addSubview(searchBar)
        
        searchBarLeadingAnchor = searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15)
        searchBarBottomAnchor = searchBar.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -30)
        searchBarTopAnchor = searchBar.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 20)
        searchBarBottomAnchor.priority = UILayoutPriority(10)
        searchBarTrailingAnchor = searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width / 2)
        
        NSLayoutConstraint.activate([
            searchBarLeadingAnchor,
            searchBarBottomAnchor,
            searchBarTopAnchor,
            searchBar.heightAnchor.constraint(equalToConstant: Dimensions.searchBarHeight),
            searchBarTrailingAnchor
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let delta = offset - lastOffset
        
        headerViewHeightAnchor.constant -= delta
        
        if headerView.frame.size.height <= Dimensions.scrollInset * 0.8 && headerView.frame.size.height >= Dimensions.scrollInset * 0.6 {
            if searchBarLeadingAnchor.constant < 0 {
                searchBarLeadingAnchor.constant = 0
            }
            if searchBarLeadingAnchor.constant > 10 {
                searchBarLeadingAnchor.constant = 10
            }
            searchBarLeadingAnchor.constant -= delta/5
        }
        
        if offset < 0 {
            headerView.alpha = -offset/((Dimensions.scrollInset + 20)/3) - 2
        }
        
        if searchBar.frame.minY == 20.0 {
            searchBarTrailingAnchor.constant = 0
            searchBar.layer.cornerRadius = 0
            searchBar.layer.shadowOpacity = 0.2
        } else {
            searchBar.layer.shadowOpacity = 0.0
            searchBar.layer.cornerRadius = 5
            searchBarTrailingAnchor.constant = -view.frame.size.width / 2
        }
    
        lastOffset = offset
    }
}

//MARK: collectionView CompositionalLayout & DiffableDataSource

extension MainViewController: UICollectionViewDelegate {
    
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
            if kind == "UICollectionElementKindSectionFooter" {
                guard let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionFooter.reuseIdentifier, for: indexPath) as? SectionFooter else {
                       return nil
                   }
                   return sectionFooter
               }
            
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
            case "categories":
                return self.createCategoriesSection(using: section)
            default:
                return self.createItemSection(using: section)
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        layout.configuration = config
        return layout
    }
    
    func createItemSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(180))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        if section.type == "best" {
            let footer = createSectionFooter()
            layoutSection.boundarySupplementaryItems.append(footer)
        }
        
        return layoutSection
    }
    
    func createCategoriesSection(using section: Section) -> NSCollectionLayoutSection {
        let edge = (view.frame.width) / 2.5
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(edge), heightDimension: .absolute(edge))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(150))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return layoutSection
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(70))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
    func createSectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
        return layoutSectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let message = sections[indexPath.section].items[indexPath.row].title
        let ac = UIAlertController(title: "You selected:", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
