//
//  ScreenshotsCell.swift
//  AppStore
//
//  Created by David Rodrigues on 14/09/2018.
//  Copyright © 2018 David Rodrigues. All rights reserved.
//

import UIKit

class ScreenshotsCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var app: App? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    let divideLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    let cellId = "cellId"
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        addSubview(divideLineView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "H:|-14-[v0]|", views: divideLineView)
        addConstraintsWithFormat(format: "V:|[v0][v1(1)]|", views: collectionView, divideLineView)
        
        collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.Screenshots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotImageCell
        
        if let imageName = app?.Screenshots?[indexPath.item] {
            cell.imageView.image = UIImage(named: imageName)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: frame.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    private class ScreenshotImageCell: BaseCell {
        
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            return iv
        }()
        
        override func setupViews() {
            super.setupViews()
            
            layer.masksToBounds = true
            
            addSubview(imageView)
            addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
            addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
        }
    }

}
