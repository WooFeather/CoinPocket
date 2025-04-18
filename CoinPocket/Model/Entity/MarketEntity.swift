//
//  MarketEntity.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

struct MarketEntity {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Double // 현재가
    let high24h: Double? // 24시간 고가
    let low24h: Double? // 24시간 저가
    let priceChangePercentage24h: Double? // 24시간 변동폭
    let ath: Double // 사상 최고가(신고점)
    let athDate: String // 신고점 일자
    let atl: Double // 사상 최저가(신저점)
    let atlDate: String // 신저점 일자
    let lastUpdated: String // 최근 업데이트 시간
    let sparklineIn7d: SparklineData?
}

struct SparklineData {
    let price: [Double] // 일주일간 코인 시세
}


extension MarketDTO {
    func toEntity() -> MarketEntity {
        MarketEntity(
            id: self.id,
            name: self.name,
            symbol: self.symbol,
            image: self.image,
            currentPrice: self.currentPrice,
            high24h: self.high24h,
            low24h: self.low24h,
            priceChangePercentage24h: self.priceChangePercentage24h,
            ath: self.ath,
            athDate: self.athDate,
            atl: self.atl,
            atlDate: self.atlDate,
            lastUpdated: self.lastUpdated,
            sparklineIn7d: self.sparklineIn7d.map { SparklineData(price: $0.price)
            }
        )
    }
}
