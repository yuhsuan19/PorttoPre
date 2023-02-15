//
//  AssetDetailViewController.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/15.
//

import UIKit

final class AssetDetailViewController: UIViewController {
    
    let viewModel: AssetDetailViewModel
    
    
    // MARK: - Object life cycle
    init(viewModel: AssetDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
