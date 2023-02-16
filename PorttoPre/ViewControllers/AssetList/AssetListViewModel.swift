//
//  AssetListViewModel.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/14.
//

import Foundation

final class AssetListViewModel {
    
    let ethAddress: String
    
    private let provider: NetworkServiceProvider
    
    private(set) var isLoading: Bool = false {
        didSet {
            onLoadingStatusChange?()
        }
    }
    
    var onLoadingStatusChange: (() -> Void)?
        
    init(provider: NetworkServiceProvider, ethAddress: String, perPageAmount: Int = 20) {
        self.provider = provider
        
        self.ethAddress = ethAddress
        self.perPageCount = perPageAmount
    }
    
    // MARK: - Assets
    private(set) var assets: [Asset] = [] {
        didSet {
            onAssetsFetch?()
        }
    }
    
    var onAssetsFetch: (() -> Void)?

    private var allAssetsLoaded: Bool = false

    private let perPageCount: Int
    
    func fetchAssets() {
        guard !isLoading && !allAssetsLoaded else { return }
        
        isLoading = true
        provider.request(for: FetchAssetsAPI(owner: ethAddress,
                                             perPageAmount: perPageCount,
                                             offset: assets.count),
                         modelType: FetchAssetsResponse.self) { result in
            switch result {
            case .success(let response):
                self.assets.append(contentsOf: response.assets)
                self.onAssetsFetch?()
                self.allAssetsLoaded = (response.assets.count < self.perPageCount)
                
            case .failure(let error):
                print(error)
            }
            self.isLoading = false
        }
    }
    
    // MARK: - Eth Balance
    private(set) var ethBalance: Int64? = nil {
        didSet {
            onETHBalanceFetch?()
        }
    }
    var onETHBalanceFetch: (() -> Void)?
    
    func fetchEthBalance() {
        provider.request(for: FetchEthBalance(ethAddress: ethAddress),
                         modelType: FetchEthBalanceResponse.self) { result in
            switch result {
            case .success(let response):
                self.ethBalance = response.balance
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
