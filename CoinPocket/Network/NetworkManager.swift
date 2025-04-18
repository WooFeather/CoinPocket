//
//  NetworkManager.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation
import Alamofire

protocol NetworkManagerType {
    func fetchData<T: Decodable, U: Router>(_ api: U) async throws -> T
}

final class NetworkManager: NetworkManagerType {

    static let shared: NetworkManagerType = NetworkManager()
    private init() { }

    func fetchData<T: Decodable, U: Router>(_ api: U) async throws -> T {

        let dataTask = AF.request(api)
            .validate(statusCode: 200..<300)
            .serializingData()
        
        print(api.urlRequest?.url ?? "")

        let result = await dataTask.result

        switch result {
        case .success(let data):
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decoding(error)
            }

        case .failure(let error):

            if let status = error.responseCode {
                throw NetworkError(statusCode: status)
            }

            if let urlError = error.underlyingError as? URLError {
                if urlError.code == .cannotLoadFromNetwork {
                    throw NetworkError.corsError
                }
                throw NetworkError.transport(urlError)
            }

            throw NetworkError.transport(error)
        }
    }
}
