//
//  APIError.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/13.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case encodingFail
    case decodingFail
    case statusCode(code: Int)
}
