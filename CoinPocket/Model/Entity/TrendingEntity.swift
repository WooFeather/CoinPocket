//
//  TrendingEntity.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

struct TrendingEntity {
    let coins: [TrendingCoinEntity]
    let nfts: [TrendingNFTEntity]
}

struct TrendingCoinEntity {
    let item: TrendingCoinDetailEntity
}

struct TrendingCoinDetailEntity {
    let id: String
    let name: String
    let symbol: String
    let marketCapRank: Int
    let small: String
    let data: TrendingCoinDataEntity
}

struct TrendingCoinDataEntity {
    let price: Double
    let priceChangePercentage24h: [String: Double] // priceChangePercentage24h["krw"]
}

struct TrendingNFTEntity {
    let name: String
    let symbol: String
    let thumb: String
    let data: TrendingNFTDataEntity
}

struct TrendingNFTDataEntity {
    let floorPrice: String
    let floorPriceInUSD24hPercentageChange: String
}

extension TrendingDTO {
    func toEntity() -> TrendingEntity {
        
        let coinEntities: [TrendingCoinEntity] = coins.map { container in
            let dto = container.item
            
            let coinData = TrendingCoinDataEntity(
                price: dto.data.price,
                priceChangePercentage24h: dto.data.priceChangePercentage24h
            )
            
            let detail = TrendingCoinDetailEntity(
                id: dto.id,
                name: dto.name,
                symbol: dto.symbol,
                marketCapRank: dto.marketCapRank,
                small: dto.small,
                data: coinData
            )
            
            return TrendingCoinEntity(item: detail)
        }
        
        let nftEntities: [TrendingNFTEntity] = nfts.map { nftDTO in
            let nftData = TrendingNFTDataEntity(
                floorPrice: nftDTO.data.floorPrice,
                floorPriceInUSD24hPercentageChange: nftDTO.data.floorPriceInUSD24hPercentageChange
            )
            
            return TrendingNFTEntity(
                name: nftDTO.name,
                symbol: nftDTO.symbol,
                thumb: nftDTO.thumb,
                data: nftData
            )
        }
        
        return TrendingEntity(
            coins: coinEntities,
            nfts: nftEntities
        )
    }
}
