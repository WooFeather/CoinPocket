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
    let priceChangePercentage24hKRW: Double
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
                priceChangePercentage24hKRW: dto.data.priceChangePercentage24h["krw"] ?? 0.0
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

extension TrendingEntity {
    static var mockData: TrendingEntity {
        let coins: [TrendingCoinEntity] = [
            .init(item: .init(id:"bitcoin", name:"Bitcoin", symbol:"BTC", marketCapRank:1,
                              small:"https://coin-images.coingecko.com/coins/images/1/small/bitcoin.png",
                              data:.init(price:86_360.74, priceChangePercentage24hKRW:-3.85))),
            
            .init(item: .init(id:"ethereum", name:"Ethereum", symbol:"ETH", marketCapRank:2,
                              small:"https://coin-images.coingecko.com/coins/images/279/small/ethereum.png",
                              data:.init(price:2_188.03, priceChangePercentage24hKRW:-1.05))),
            
            .init(item: .init(id:"solana", name:"Solana", symbol:"SOL", marketCapRank:6,
                              small:"https://coin-images.coingecko.com/coins/images/4128/small/solana.png",
                              data:.init(price:138.29, priceChangePercentage24hKRW:-4.81))),
            
            .init(item: .init(id:"ondo-finance", name:"Ondo", symbol:"ONDO", marketCapRank:41,
                              small:"https://coin-images.coingecko.com/coins/images/26580/small/ONDO.png",
                              data:.init(price:0.9525, priceChangePercentage24hKRW:-9.09))),
            
            .init(item: .init(id:"the-open-network", name:"Toncoin", symbol:"TON", marketCapRank:25,
                              small:"https://coin-images.coingecko.com/coins/images/17980/small/photo_2024-09-10_17.09.00.jpeg",
                              data:.init(price:2.9868, priceChangePercentage24hKRW:-2.51))),
            
            .init(item: .init(id:"zignaly", name:"ZIGChain", symbol:"ZIG", marketCapRank:356,
                              small:"https://coin-images.coingecko.com/coins/images/14796/small/zig.jpg",
                              data:.init(price:0.09525, priceChangePercentage24hKRW:-2.48)))
        ]
        
        let nfts: [TrendingNFTEntity] = [
            .init(name:"Wealthy Hypio Babies", symbol:"HYPIO",
                  thumb:"https://coin-images.coingecko.com/nft_contracts/images/15671/standard/wealthy-hypio-babies.png",
                  data:.init(floorPrice:"1.09 ETH", floorPriceInUSD24hPercentageChange:"21.54387552656127")),
            
            .init(name:"Band Bears", symbol:"BANDB",
                  thumb:"https://coin-images.coingecko.com/nft_contracts/images/3137/standard/the-band-bears.png",
                  data:.init(floorPrice:"11.11 ETH", floorPriceInUSD24hPercentageChange:"17.14734634169384")),
            
            .init(name:"Moonbirds", symbol:"MOONBIRD",
                  thumb:"https://coin-images.coingecko.com/nft_contracts/images/349/standard/moobirds.webp",
                  data:.init(floorPrice:"0.54 ETH", floorPriceInUSD24hPercentageChange:"7.098650935295411")),
            
            .init(name:"Creepz by OVERLORD", symbol:"CBC",
                  thumb:"https://coin-images.coingecko.com/nft_contracts/images/1326/standard/creepz-genesis.png",
                  data:.init(floorPrice:"2.09 ETH", floorPriceInUSD24hPercentageChange:"3.885820610207682")),
            
            .init(name:"Claynosaurz", symbol:"CLAYNOSAURZ",
                  thumb:"https://coin-images.coingecko.com/nft_contracts/images/2446/standard/claynosaurz.gif",
                  data:.init(floorPrice:"16.50 SOL", floorPriceInUSD24hPercentageChange:"2.594313916820804")),
            
            .init(name:"mfers", symbol:"MFER",
                  thumb:"https://coin-images.coingecko.com/nft_contracts/images/312/standard/mfers.png",
                  data:.init(floorPrice:"0.47 ETH", floorPriceInUSD24hPercentageChange:"21.54387552656127"))
        ]
        
        return TrendingEntity(coins: coins, nfts: nfts)
    }
}
