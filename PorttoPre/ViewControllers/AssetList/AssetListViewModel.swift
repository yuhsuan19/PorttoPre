//
//  AssetListViewModel.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/14.
//

import Foundation

final class AssetListViewModel {
    
    let ethAddress: String
    
    var assets: [Asset] = [] {
        didSet {
            print(assets)
        }
    }
    
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
                
            case .failure(let error):
                break
            }
        }
    }
}
