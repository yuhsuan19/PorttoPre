//
//  AssetListViewModel.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/14.
//

import Foundation

final class AssetListViewModel {
    
    let ethAddress: String
    
    private(set) var isLoading: Bool = false {
        didSet {
            onIsLoadingChanged?()
        }
    }
    private var isLoadAll: Bool = false
    
    var onIsLoadingChanged: (() -> Void)?
    
    var assets: [Asset] = []
    
    var onAssetsFetched: ((Error?) -> Void)?
    
    private let perPageCount: Int
    
    private let provider: NetworkServiceProvider
    
    init(provider: NetworkServiceProvider, ethAddress: String, perPageAmount: Int = 20) {
        self.provider = provider
        
        self.ethAddress = ethAddress
        self.perPageCount = perPageAmount
    }
    
    func fetchAssets() {
        guard !isLoading && !isLoadAll else { return }
        
        isLoading = true
        provider.request(for: FetchAssetsAPI(owner: ethAddress,
                                             perPageAmount: perPageCount,
                                             offset: assets.count),
                         modelType: FetchAssetsResponse.self) { result in
            switch result {
            case .success(let response):
                self.assets.append(contentsOf: response.assets)
                self.onAssetsFetched?(nil)
                self.isLoadAll = (response.assets.count < self.perPageCount)
            case .failure(let error):
                self.onAssetsFetched?(error)
            }
            self.isLoading = false
        }
    }
}
