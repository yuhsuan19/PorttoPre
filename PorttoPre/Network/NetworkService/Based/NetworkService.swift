//
//  NetworkService.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/13.
//

import Foundation

enum HTTPMethod: String {
    case `get` = "GET"
    case post = "POST"
}

enum NetworkServiceParameter {
    case queryItems(parameters: [String: Any])
    case dictionaryBody(parameters: [String: Any])
    case encodableBody(object: Encodable)
    case none
}

protocol NetworkService {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var headers: [String: String]? { get }
    
    var httpMethod: HTTPMethod { get }
    
    var parameters: NetworkServiceParameter { get }
    
    var timeout: TimeInterval { get }
}

extension NetworkService {
    var timeout: TimeInterval { return 10 }
    
    var request: URLRequest {
        
        var request = URLRequest(url: baseURL.appendingPathComponent(path),
                                     cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                     timeoutInterval: timeout)
        request.allHTTPHeaderFields = headers
        request.httpMethod = httpMethod.rawValue
        
        do {
            switch parameters {
            case .queryItems(let parameters):
                try encodeQueryItems(urlRequest: &request, parameters: parameters)
            case .dictionaryBody(let parameters):
                try encodeDictionaryBody(urlRequest: &request, parameters: parameters)
            case .encodableBody(let object):
                try encodeEncodableBody(urlRequest: &request, encodableObject: object)
            case .none:
                break
            }
        } catch {
            fatalError("Fail to configure url request")
        }
        
        return request
    }
}

// MARK: - Encoding
extension NetworkService {
    private func encodeQueryItems(urlRequest: inout URLRequest, parameters: [String : Any]?) throws {
        
        guard let url = urlRequest.url,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        
        if let parameters = parameters, !parameters.isEmpty {
            
            urlComponents.queryItems = []

            parameters.forEach() { (key: String, value: Any) in
                
                if let arrayValue = value as? [Any] {
                    arrayValue.forEach() {
                        let queryItem = URLQueryItem(name: key+"[]",
                                                     value:  "\($0)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                        urlComponents.queryItems?.append(queryItem)
                    }
                } else {
                    let queryItem = URLQueryItem(name: key,
                                                 value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
            }
            
            urlRequest.url = urlComponents.url
        }
        
        urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
    
    private func encodeDictionaryBody(urlRequest: inout URLRequest, parameters: [String : Any]?) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters ?? [:], options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            throw APIError.encodingFail
        }
    }
    
    private func encodeEncodableBody(urlRequest: inout URLRequest, encodableObject: Encodable?) throws {
        do {
            guard let object = encodableObject else {
                throw APIError.encodingFail
            }
            let jsonData = try JSONEncoder().encode(object)
            urlRequest.httpBody = jsonData
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            throw APIError.encodingFail
        }
    }
}
