//
//  AssetListViewController.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/13.
//

import UIKit
import ProgressHUD

protocol AssetListViewControllerDelegate: AnyObject {
    func assetListViewControlerDidSelectAsset(_ selectedAsset: Asset) -> Void
}

final class AssetListViewController: UIViewController {
        
    private let viewModel: AssetListViewModel
    
    private weak var delegate: AssetListViewControllerDelegate?
    
    private lazy var assetListCollectionView: AssetListCollectionView = {
        let collectionView = AssetListCollectionView(delegate: self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Object life cycle
    init(viewModel: AssetListViewModel, delegate: AssetListViewControllerDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
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
        viewModel.fetchEthBalance()
    }

    private func setUpViews() {
        title = "Balance: Fetching..."
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(assetListCollectionView)
        NSLayoutConstraint.activate([
            assetListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            assetListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            assetListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            assetListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onLoadingStatusChange = { [weak self] in
            if (self?.viewModel.isLoading ?? false) && (self?.viewModel.assets.isEmpty ?? false) {
                ProgressHUD.show()
            } else {
                ProgressHUD.dismiss()
            }
        }
        
        viewModel.onAssetsFetch = { [weak self] in
            guard let self = self else { return }
            self.assetListCollectionView.setAssets(self.viewModel.assets)
        }
        
        viewModel.onETHBalanceFetch = { [weak self] in
            guard let ethBalance = self?.viewModel.ethBalance else {
                self?.title = "Balance: Fail to Fetch"
                return
            }
            self?.title = "Balance: \(ethBalance) eth"
        }
    }
}

// MARK: - UICollectionView Delegate
extension AssetListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case assetListCollectionView:
            delegate?.assetListViewControlerDidSelectAsset(viewModel.assets[indexPath.item])
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case assetListCollectionView:
            if indexPath.item > viewModel.assets.count - 8 {
                viewModel.fetchAssets()
            }
         default:
            break
        }
    }
}
