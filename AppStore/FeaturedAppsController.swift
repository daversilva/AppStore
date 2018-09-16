//
//  ViewController.swift
//  AppStore
//
//  Created by David Rodrigues on 09/09/2018.
//  Copyright © 2018 David Rodrigues. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController {
    
    private let cellId = "cellId"
    private let largeCellId = "largeCellId"
    private let headerId = "headerId"
    
    var featuredApps: Featured?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Featured Apps"
        
        Network.shared.fetchedGenericData { (featured: Result<Featured>) in
            switch featured {
                case let .success(featured):
                    self.featuredApps = featured
                    self.collectionView?.reloadData()
                case let .failure(error) :
                    print(error)
            }
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredApps?.categories?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
            cell.appCategory = featuredApps?.categories?[indexPath.item]
            cell.featuredAppsController = self
            return cell
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.appCategory = featuredApps?.categories?[indexPath.item]
        cell.featuredAppsController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
        header.appCategory = featuredApps?.bannerCategory
        return header
    }
    
    func showAppDetailForApp(_ app: App) {
        let layout = UICollectionViewFlowLayout()
        let appDetailController = AppDetailController(collectionViewLayout: layout)
        appDetailController.app = app
        navigationController?.pushViewController(appDetailController, animated: true)
    }

}

extension FeaturedAppsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: 160)
        }
        
        return CGSize(width: view.frame.width, height: 230)
    }
}

class HeaderCell: CategoryCell {
    
    let cellId = "cellId"
    
    override func setupViews() {
        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
        
        appsCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(appsCollectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: appsCollectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: appsCollectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2 + 50, height: frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private class BannerCell: AppCell {
        override func setupViews() {
            imageView.layer.cornerRadius = 0
            imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
            imageView.layer.borderWidth = 0.5
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(imageView)
            addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
            addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
        }
    }
}

class LargeCategoryCell: CategoryCell {
    
    private let largeAppCellId = "largeAppCellId"
    
    override func setupViews() {
        super.setupViews()
        appsCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: largeAppCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeAppCellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 32)
    }
    
    private class LargeAppCell: AppCell {
        override func setupViews() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
            addConstraintsWithFormat(format: "V:|-2-[v0]-14-|", views: imageView)
        }
    }
}
