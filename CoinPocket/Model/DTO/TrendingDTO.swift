//
//  TrendingDTO.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

// MARK: - Root
struct TrendingDTO: Codable {
    let coins: [CoinContainer]
    let nfts: [NFTDTO]
    let categories: [CategoryDTO]
}

// MARK: - Coin Container
struct CoinContainer: Codable, Identifiable {
    let item: CoinItemDTO
    var id: String { item.id }
}

// MARK: - Coin Item
struct CoinItemDTO: Codable, Identifiable {
    let id: String
    let coinId: Int
    let name: String
    let symbol: String
    let marketCapRank: Int
    let thumb: String
    let small: String
    let large: String
    let slug: String
    let priceBtc: Double
    let score: Int
    let data: CoinDataDTO

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug, score, data, thumb, small, large
        case coinId = "coin_id"
        case marketCapRank = "market_cap_rank"
        case priceBtc = "price_btc"
    }
}

// MARK: - Coin Data
struct CoinDataDTO: Codable {
    let price: Double
    let priceBtc: String
    let priceChangePercentage24h: [String: Double]
    let marketCap: String
    let marketCapBtc: String
    let totalVolume: String
    let totalVolumeBtc: String
    let sparkline: String
    let content: ContentDTO?

    enum CodingKeys: String, CodingKey {
        case price, sparkline, content
        case priceBtc = "price_btc"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
    }
}

// MARK: - Optional Content
struct ContentDTO: Codable {
    let title: String?
    let description: String?
}

// MARK: - NFT
struct NFTDTO: Codable, Identifiable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let nftContractID: Int
    let nativeCurrencySymbol: String
    let floorPriceInNativeCurrency: Double
    let floorPrice24hPercentageChange: Double
    let data: NFTDataDTO

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, thumb, data
        case nftContractID = "nft_contract_id"
        case nativeCurrencySymbol = "native_currency_symbol"
        case floorPriceInNativeCurrency = "floor_price_in_native_currency"
        case floorPrice24hPercentageChange = "floor_price_24h_percentage_change"
    }
}

// MARK: - NFT Data
struct NFTDataDTO: Codable {
    let floorPrice: String
    let floorPriceInUSD24hPercentageChange: String
    let h24Volume: String
    let h24AverageSalePrice: String
    let sparkline: String
    let content: ContentDTO?

    enum CodingKeys: String, CodingKey {
        case sparkline, content
        case floorPrice = "floor_price"
        case floorPriceInUSD24hPercentageChange = "floor_price_in_usd_24h_percentage_change"
        case h24Volume = "h24_volume"
        case h24AverageSalePrice = "h24_average_sale_price"
    }
}

// MARK: - Category
struct CategoryDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let marketCap1hChange: Double
    let slug: String
    let coinsCount: Int
    let data: CategoryDataDTO

    enum CodingKeys: String, CodingKey {
        case id, name, slug, data
        case marketCap1hChange = "market_cap_1h_change"
        case coinsCount = "coins_count"
    }
}

// MARK: - Category Data
struct CategoryDataDTO: Codable {
    let marketCap: Double
    let marketCapBtc: Double
    let totalVolume: Double
    let totalVolumeBtc: Double
    let marketCapChangePercentage24h: [String: Double]
    let sparkline: String

    enum CodingKeys: String, CodingKey {
        case sparkline
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
    }
}
