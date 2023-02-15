//
//  AssetListViewModel.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/14.
//

import Foundation

final class AssetListViewModel {
    
    let ethAddress: String
    
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
        provider.request(for: FetchAssetsAPI(owner: ethAddress,
                                             perPageAmount: perPageCount, offset: 0),
                         modelType: FetchAssetsResponse.self) { result in
            switch result {
            case .success(let response):
                self.assets.append(contentsOf: response.assets)
                self.onAssetsFetched?(nil)
                
            case .failure(let error):
                self.onAssetsFetched?(error)
            }
        }
    }
}
