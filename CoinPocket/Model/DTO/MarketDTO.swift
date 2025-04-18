//
//  MarketDTO.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

// MARK: - Root
struct MarketDTO: Decodable, Identifiable {
    // 기본 정보
    let id: String
    let symbol: String
    let name: String
    let image: String

    // 시세·지표
    let currentPrice: Double
    let marketCap: Double
    let marketCapRank: Int
    let fullyDilutedValuation: Double?
    let totalVolume: Double
    let high24h: Double
    let low24h: Double
    let priceChange24h: Double
    let priceChangePercentage24h: Double
    let marketCapChange24h: Double
    let marketCapChangePercentage24h: Double

    // 공급량
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?

    // 최고가/최저가
    let ath: Double
    let athChangePercentage: Double
    let athDate: String
    let atl: Double
    let atlChangePercentage: Double
    let atlDate: String

    // ROI (null 가능)
    let roi: ROI?
    
    // 최신 업데이트 시각
    let lastUpdated: String
    
    // 7일 스파크라인
    let sparklineIn7d: SparklineDTO?
    
    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image, roi
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h  = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath, atl
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7d = "sparkline_in_7d"
    }
}

// MARK: - ROI (nullable)
struct ROI: Decodable {
    let times: Double?
    let currency: String?
    let percentage: Double?
}

// MARK: - Sparkline
struct SparklineDTO: Decodable {
    let price: [Double]
}
