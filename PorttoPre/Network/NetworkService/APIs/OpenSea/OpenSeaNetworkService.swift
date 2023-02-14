//
//  OpenSeaNetworkService.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/14.
//

import Foundation

protocol OpenSeaNetworkService: NetworkService { }

extension OpenSeaNetworkService {
    var baseURL: URL {
        URL(string: "https://testnets-api.opensea.io/")!
    }
    
    var headers: [String : String]? {
        nil
    }
}
