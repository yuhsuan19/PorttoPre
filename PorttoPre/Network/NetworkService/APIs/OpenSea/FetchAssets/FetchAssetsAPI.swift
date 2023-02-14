//
//  FetchAssets.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/14.
//

import Foundation

struct FetchAssetsAPI {
    let owner: String
    let perPageAmount: Int
    let offset:Int
}

extension FetchAssetsAPI: OpenSeaNetworkService {
    var path: String {
        "api/v1/assets"
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var parameters: NetworkServiceParameter {
        .queryItems(parameters: [
            "owner": owner,
            "limit": perPageAmount,
            "offset": offset,
            "format": "json"
        ])
    }
}
