//
//  GetEthBalanceResponse.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/16.
//

import Foundation

struct FetchEthBalanceResponse: Decodable {
    let result: String
    
    var balance: Int64 {
        print(result)
        let hex = result.replacingOccurrences(of: "0x", with: "")
        return Int64(hex, radix: 16) ?? 0
    }
}
