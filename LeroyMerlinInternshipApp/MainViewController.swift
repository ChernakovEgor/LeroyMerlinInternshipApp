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
}

class MainViewController: UIViewController {

    var sections = Section.sections
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    var lastOffset: CGFloat = -20
    
    var searchBar: UITextField!
    var searchBarLeadingAnchor: NSLayoutConstraint!
  
    var searchBarWidthAnchor: NSLayoutConstraint!
    var bottomAnchor: NSLayoutConstraint!
    let whiteView = UIView()
    
    var header: MainSectionHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
    }
    
    func setupCollectionView() {
        let green = UIView()
        green.backgroundColor = Dimensions.color
        green.frame = CGRect(x: 0, y: -400, width: view.frame.size.width, height: 400)
        green.layer.zPosition = -1
       
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        collectionView.addSubview(green)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseIdentifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(SectionFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooter.reuseIdentifier)
        collectionView.register(MainSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainSectionHeader.reuseIdentifier)
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        collectionView.delegate = self
        
        createDataSource()
        reloadData()
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    @objc func handleRefreshControl() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }

    
    func setupSearchBar() {
        searchBar = UITextField()
        searchBar.placeholder = "  Поиск"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.backgroundColor = .white
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        whiteView.backgroundColor = .white
        whiteView.frame = CGRect(x: 0, y: -50, width: view.frame.size.width, height: 70)
        
        view.addSubview(whiteView)
        view.addSubview(searchBar)
        
        bottomAnchor = searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -30)
        bottomAnchor.priority = UILayoutPriority(10)
        
        searchBarLeadingAnchor = searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        searchBarLeadingAnchor.priority = UILayoutPriority(10)
        searchBarWidthAnchor = searchBar.widthAnchor.constraint(equalTo: view.widthAnchor)
        
        NSLayoutConstraint.activate([
            bottomAnchor,
            searchBar.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 20),
            searchBarLeadingAnchor,
            searchBar.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(lessThanOrEqualTo: header.leadingAnchor, constant: 15),
            searchBar.heightAnchor.constraint(equalToConstant: Dimensions.searchBarHeight)
        ])
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
       
        let delta = offset - lastOffset
        lastOffset = offset
        
        if offset < 20.0 {
            searchBarLeadingAnchor.constant = 15
        }
        else if offset <= 100.0 {
            searchBarLeadingAnchor.constant -= delta
        }

        if offset > 0 {
            header.alpha = 40.0 / offset - 1
        } else {
            header.alpha = 1.0
        }
        
        if searchBar.frame.minY == 20.0 {
            searchBar.layer.cornerRadius = 0
            searchBar.layer.shadowOpacity = 0.2
            searchBarWidthAnchor.isActive = true
            whiteView.alpha = 1
        } else {
            searchBar.layer.shadowOpacity = 0.0
            searchBar.layer.cornerRadius = 5
            searchBarWidthAnchor.isActive = false
            whiteView.alpha = 0
        }
    }
}

//MARK: collectionView CompositionalLayout & DiffableDataSource

extension MainViewController: UICollectionViewDelegate {
    
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with item: Item, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
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
            if indexPath.section == 0 {
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainSectionHeader.reuseIdentifier, for: indexPath) as? MainSectionHeader else { return nil }
                self?.header = sectionHeader
                return sectionHeader
            }
            
         guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
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
        
        let header = createMainSectionHeader()
        layoutSection.boundarySupplementaryItems = [header]
        
        return layoutSection
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(70))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
    func createMainSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
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
