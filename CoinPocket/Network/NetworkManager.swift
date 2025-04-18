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
        let response = AF.request(api).validate(statusCode: 200...499).serializingDecodable(T.self)
        switch await response.result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}
