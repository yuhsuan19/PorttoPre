//
//  AssetListCollectionView.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/14.
//

import UIKit

final class AssetListCollectionView: UICollectionView {
    private static var itemSize: CGSize {
        let width = ((UIScreen.main.bounds.width - 20) * 0.9) / 2
        let height = width / 0.8
        return CGSize(width: width, height: height)
    }
    
    private var assets: [Asset] = [] {
        didSet {
            reloadData()
        }
    }
    
    init(frame: CGRect = .zero) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Self.itemSize
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .clear
        register(AssetListCollectionViewCell.self, forCellWithReuseIdentifier: "AssetListCell")
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAssets(_ assests: [Asset]) {
        self.assets = assests
    }
}

// MARK: - Data source
extension AssetListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetListCell", for: indexPath) as! AssetListCollectionViewCell
        cell.setAsset(assets[indexPath.item])
        return cell
    }
}
