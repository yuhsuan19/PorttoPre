//
//  AssetListCoordinator.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/13.
//

import Foundation
import UIKit

final class AssetListCoordinator: Coordinator {
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let ethAddress = "0x85fD692D2a075908079261F5E351e7fE0267dB02"
        
        let viewModel = AssetListViewModel(provider: NetworkServiceProvider.shared,
                                           ethAddress: ethAddress)
        let assetListViewController = AssetListViewController(viewModel: viewModel)
        presenter.pushViewController(assetListViewController, animated: true)
    }
}
