//
//  NetworkServiceProvider.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/14.
//

import Foundation

final class NetworkServiceProvider {
    
    static let shared = NetworkServiceProvider(urlRequestProivder: URLRequestProvider())
    
    private let urlRequestProvider: URLRequestProvider
    
    private init(urlRequestProivder: URLRequestProvider) {
        self.urlRequestProvider = urlRequestProivder
    }
    
    @discardableResult func request<Model: Decodable>(for service: NetworkService, modelType: Model.Type, completion: @escaping (Result<Model, Error>) -> Void) -> URLSessionDataTask {
        return urlRequestProvider.request(urlResquest: service.request) { result in
            switch result {
            case.success(let networkResponse):
                guard networkResponse.response.statusCode >= 200 && networkResponse.response.statusCode < 300 else {
                    completion(.failure(APIError.statusCode(code: networkResponse.response.statusCode)))
                    return
                }

                do {
                    let dataModel = try JSONDecoder().decode(Model.self, from: networkResponse.data)
                    completion(.success(dataModel))
                } catch {
                    completion(.failure(APIError.decodingFail))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
