//
//  AssetListViewController.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/13.
//

import UIKit

final class AssetListViewController: UIViewController {
    
    private let viewModel: AssetListViewModel
    
    private lazy var collectionView: AssetListCollectionView = {
        let collectionView = AssetListCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Object life cycle
    init(viewModel: AssetListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        bindViewModel()
        
        viewModel.fetchAssets()
    }

    private func setUpViews() {
        title = "ETH"
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onAssetsFetched = { [weak self] (error) in
            guard let self = self else { return }
            self.collectionView.setAssets(self.viewModel.assets)
        }
    }
}
