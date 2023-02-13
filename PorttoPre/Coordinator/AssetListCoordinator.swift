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
        let assetListViewController = AssetListViewController()
        presenter.pushViewController(assetListViewController, animated: true)
    }
}
