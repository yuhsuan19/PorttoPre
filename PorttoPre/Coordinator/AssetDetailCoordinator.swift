//
//  AssetDetailCoordinator.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/15.
//

import Foundation
import UIKit

final class AssetDetailCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let asset: Asset
    private var assetDetailViewController: AssetDetailViewController?
    
    init(presenter: UINavigationController, asset: Asset) {
        self.presenter = presenter
        self.asset = asset
    }
    
    func start() {
        let viewModel = AssetDetailViewModel(asset: asset)
        let assetDetailViewController = AssetDetailViewController(viewModel: viewModel)
        self.assetDetailViewController = assetDetailViewController
        presenter.pushViewController(assetDetailViewController, animated: true)
    }
}
