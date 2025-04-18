//
//  SearchDTO.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

// MARK: - Root
struct SearchDTO: Codable {
    let coins: [SearchCoinDTO]
    let exchanges: [SearchExchangeDTO]
    let icos: [String]
    let categories: [SearchCategoryDTO]
    let nfts: [SearchNftDTO]
}

// MARK: - Category
struct SearchCategoryDTO: Codable {
    let id, name: String
}

// MARK: - Coin
struct SearchCoinDTO: Codable {
    let id, name, apiSymbol, symbol: String
    let marketCapRank: Int
    let thumb, large: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case apiSymbol = "api_symbol"
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb, large
    }
}

// MARK: - Exchange
struct SearchExchangeDTO: Codable {
    let id, name, marketType: String
    let thumb, large: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case marketType = "market_type"
        case thumb, large
    }
}

// MARK: - Nft
struct SearchNftDTO: Codable {
    let id, name, symbol: String
    let thumb: String
}
