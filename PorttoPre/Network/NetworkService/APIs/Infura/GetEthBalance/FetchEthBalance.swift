//
//  GetEthBalance.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/16.
//

import Foundation

struct FetchEthBalance {
    let ethAddress: String
}

extension FetchEthBalance: InfuraNetworkService {
    var httpMethod: HTTPMethod {
        .post
    }
    
    var parameters: NetworkServiceParameter {
        .dictionaryBody(parameters: [
            "jsonrpc": "2.0",
            "method": "eth_getBalance",
            "id": 1,
            "params": [ethAddress, "latest"]
        ])
    }
}
