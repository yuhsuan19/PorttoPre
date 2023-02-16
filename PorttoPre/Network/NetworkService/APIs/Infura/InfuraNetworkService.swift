//
//  InfuraNetworkService.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/16.
//

import Foundation

protocol InfuraNetworkService: NetworkService { }

extension InfuraNetworkService {
    private var apiKey: String {
        return "95e59064567b48dabb0734ac0cdb48be"
    }
    
    var baseURL: URL {
        URL(string: "https://mainnet.infura.io/")!
    }
    
    var path: String {
        "v3/\(apiKey)"
    }
    
    var headers: [String : String]? {
        [ "Content-Type": "application/json" ]
    }
}
