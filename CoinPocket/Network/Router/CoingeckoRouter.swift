//
//  CoingeckoRouter.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation
import Alamofire

enum CoingeckoRouter {
    case trending
    case markets(ids: [String])
    case search(query: String)
}

extension CoingeckoRouter: Router {
    var endpoint: String {
        baseURL + path
    }
    
    var baseURL: String {
        return "https://api.coingecko.com/api/v3/"
    }
    
    var path: String {
        switch self {
        case .trending:
            return "search/trending"
        case .markets:
            return "coins/markets"
        case .search:
            return "search"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    var params: Parameters {
        switch self {
        case let .markets(ids):
            return [
                "vs_currency": "krw",
                "sparkline": "true",
                "ids" : ids.joined(separator: ",")
            ]
        case .trending:
            return [:]
        case let .search(query):
            return ["query": query]
        }
    }
    
    // 파라미터 적용
    var encoding: (ParameterEncoding)? {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
