//
//  NetworkServiceProvider.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/13.
//

import Foundation

struct NetWorkResponse {
    
    var data: Data
    
    var request: URLRequest
    
    var response: HTTPURLResponse
}

final class URLRequestProvider {
    
    @discardableResult func request(urlResquest: URLRequest, completion: @escaping (Result<NetWorkResponse, Error>) -> Void) -> URLSessionDataTask {
        
        let dataTask = URLSession.shared.dataTask(with: urlResquest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.missingResponse))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(NetWorkResponse(data: data, request: urlResquest, response: response)))
            }
        }
        dataTask.resume()
        
        return dataTask
    }
}
