//
//  AssetDetailViewController.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/15.
//

import UIKit
import Kingfisher

final class AssetDetailViewController: UIViewController {
    
    let viewModel: AssetDetailViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let assetImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    private var assetImageViewHeightConstraint: NSLayoutConstraint?
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .tertiaryLabel
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open Permalink", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(tapActionButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Object life cycle
    init(viewModel: AssetDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("check")
    }
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        bindViewModel()
    }
    
    private func setUpViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -10)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [assetImageView, nameLabel, descriptionLable])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 12
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        assetImageViewHeightConstraint = assetImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48)
        assetImageViewHeightConstraint?.isActive = true
    }
    
    private func bindViewModel() {
        title = viewModel.asset.collection?.name
        
        assetImageView.setKingFisherImage(url: viewModel.asset.imageURL) { result in
            self.updateAssetImage(result: result)
        }
        
        nameLabel.text = viewModel.asset.name
        descriptionLable.text = viewModel.asset.description
    }
    
    private func updateAssetImage(result: Result<RetrieveImageResult, KingfisherError>) {
        switch result {
        case .success(let imageResult):
            let image = imageResult.image
            assetImageView.backgroundColor = .clear
            assetImageViewHeightConstraint?.constant = (image.size.height / image.size.width) * UIScreen.main.bounds.width - 48
            view.layoutIfNeeded()
        case .failure(_):
            break
        }
    }
    
    @objc private func tapActionButton() {
        guard let url = viewModel.asset.permalink else {
            return
        }
        UIApplication.shared.open(url)
    }
}
