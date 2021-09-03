//
//  ViewController.swift
//  Compotitional Layout Example
//
//  Created by Jeyaganthan's Mac Mini on 03/09/21.
//

import UIKit

class ViewController: UIViewController {

    
    let homeData = Bundle.main.decode([Section].self, from: "App.json")
    var collectionView: UICollectionView? = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Items>? = nil
    var hasTapped = [Int]()
    
    private let favoriteImage = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    private let favoriteImageFill = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
           print("Data ===>", homeData)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionlayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = .systemBackground
        collectionView?.delegate = self
        collectionView?.dataSource = self.dataSource
        guard let collectView = collectionView else { return }
        view.addSubview(collectView)
        
        self.registeredCells()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.diffableDataSource()
        self.appendingDiffableDataSourceSnapshot()
    }
    
    
    /// Register the CollectionView cells
    private func registeredCells() {
        collectionView?.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.identifier)
        collectionView?.register(UINib(nibName:"ShopByBrandCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: ShopByBrandCollectionViewCell.reuseableIdentifier)
        collectionView?.register(UINib(nibName:"NewyearCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: NewyearCollectionViewCell.reuseableIdentifier)
        collectionView?.register(UINib(nibName:"QuickLinksCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: QuickLinksCollectionViewCell.reuseableIdentifier)
        collectionView?.register(SmallTableCell.self, forCellWithReuseIdentifier: SmallTableCell.reuseableIdentifier)
        
    }
    
    
    /// Generic function for configure the Cells
    /// - Parameters:
    ///   - cellType: Generic Cell type
    ///   - travel: Items
    ///   - indexPath: IndexPAth for particular cell
    /// - Returns: Generic Cell
    private func configureCells<T: ConfiguringCell>(_ cellType: T.Type, with travel: Items, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: cellType.reuseableIdentifier, for: indexPath) as? T else { fatalError("Unable dequeu cells") }
        
        cell.configureCellLayout(with: travel)
        
        return cell
    }
    
    
    
    
    /// Create Respective Compositional CollectionView Layout
    /// - Returns: respective Layout
    private func createCompositionlayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = self.homeData[sectionIndex]
            switch section.type {
            case "Banner":
                return self.createSmallTableLayout(using: section)
            case "categories":
                return self.createcatageoryTableLayout(using: section)
            case "Brands":
                return self.createBrandTableLayout(using: section)
            case "Offers":
                return self.createOfferLayout(using: section)
            default:
                return self.createFeatureLayout(using: section)
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        layout.configuration = config
        return layout
    }


}
// MARK: - Diffable Data Source Setup

extension ViewController {
    /// Create Differable 
    private func diffableDataSource() {
        guard let collectView = collectionView else { return }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Items >(collectionView: collectView, cellProvider: { (_, indexPath, app) in
            let section = self.homeData[indexPath.section]
            switch section.type {
            case "Banner":
                return self.configureCells(SmallTableCell.self, with: app, for: indexPath)
            case "categories":
                return self.configureCells(QuickLinksCollectionViewCell.self, with: app, for: indexPath)
            case "Brands" :
                return  self.configureCells(ShopByBrandCollectionViewCell.self, with: app, for: indexPath)
            case "Offers" :
                return   self.configureCells(NewyearCollectionViewCell.self, with: app, for: indexPath)
            default :
                return self.configureCells(ShopByBrandCollectionViewCell.self, with: app, for: indexPath)
            }
            
        })
        
        /// Configuring supplementary view provider for section header
        dataSource?.supplementaryViewProvider = { collectionView, kind, IndexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.identifier, for: IndexPath) as? SectionHeaderReusableView else { fatalError("Unable to dequeu") }
            
            guard let firstItem = self.dataSource?.itemIdentifier(for: IndexPath),
                  let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: firstItem) else { return nil }
            
            if section.title.isEmpty {
                return nil
            }
            sectionHeader.title.text = section.title
            return sectionHeader
        }
        
    }
    
    private func appendingDiffableDataSourceSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Items>()
        snapshot.appendSections(homeData)
        
        for section in homeData {
            snapshot.appendItems(section.Items, toSection: section)
        }
        print("Values ==>",snapshot)
        dataSource?.apply(snapshot)
    }
    
}

// MARK: - Compositional Layout Setup

extension ViewController {
    private func createFeatureLayout(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .estimated(300))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])
        
        let layoutSection = NSCollectionLayoutSection(group: groupLayout)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        return layoutSection
    }
    
    
    private func createOfferLayout(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])
        
        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        sectionLayout.interGroupSpacing = 10
        sectionLayout.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let sectionHeaderLayout = createSectionHeaderLayout()
        sectionLayout.boundarySupplementaryItems = [sectionHeaderLayout]

        return sectionLayout
    }
    
    private func createMediumTableLayout(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .fractionalWidth(0.87))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])
        
        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        sectionLayout.interGroupSpacing = 15
        sectionLayout.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let sectionHeaderLayout = createSectionHeaderLayout()
        sectionLayout.boundarySupplementaryItems = [sectionHeaderLayout]
        
        return sectionLayout
    }
    
    
    private func createBrandTableLayout(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalWidth(0.25))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(100))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [itemLayout])
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.interGroupSpacing = 5
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let layoutSectionHeader = createSectionHeaderLayout()
        section.boundarySupplementaryItems = [layoutSectionHeader]
        
        return section
    }
    
    private func createcatageoryTableLayout(using section:Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
     heightDimension: .absolute(100))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
     item.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
     heightDimension: .estimated(500))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.interGroupSpacing = 10
                let sectionHeaderLayout = createSectionHeaderLayout()
                sectionLayout.boundarySupplementaryItems = [sectionHeaderLayout]

      return sectionLayout
    }
    
    private func createSmallTableLayout(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.95))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(200))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [itemLayout])
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    private func createSectionHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
}

// MARK: - Collection View Delegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        print("Selected item at \(homeData[indexPath.section].Items[indexPath.row])\n \(indexPath.row)")
        
    }
    
}

