//
//  AssetListViewController.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/13.
//

import UIKit

final class AssetListViewController: UIViewController {
    
    private let viewModel: AssetListViewModel
    
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
        
        viewModel.fetchAssets()
    }

    private func setUpViews() {
        view.backgroundColor = .white
    }
}
