//
//  AppCoordinator.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/13.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var assetListCoordinator: AssetListCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = rootViewController
        
        assetListCoordinator = AssetListCoordinator(presenter: rootViewController)
        assetListCoordinator?.start()
        
        window.makeKeyAndVisible()
    }
}
