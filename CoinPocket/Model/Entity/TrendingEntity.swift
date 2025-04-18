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
    let id: String
    let name: String
    let symbol: String
    let marketCapRank: Int
    let thumb: String
    let price: String
    let changeRate: String
}

struct TrendingNFTEntity {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let floorPrice: String
    let changeRate: String
}

extension TrendingDTO {
    func toEntity() -> TrendingEntity {
        let coinEntities = coins.map { container in
            let dto = container.item
            return TrendingCoinEntity(
                id: dto.id,
                name: dto.name,
                symbol: dto.symbol,
                marketCapRank: dto.marketCapRank,
                thumb: dto.thumb,
                price: dto.data.price.formatted(),
                changeRate: dto.data.priceChangePercentage24h["krw"]?.formatted() ?? ""
            )
        }

        let nftEntities = nfts.map { nftDTO in
            return TrendingNFTEntity(
                id: nftDTO.id,
                name: nftDTO.name,
                symbol: nftDTO.symbol,
                thumb: nftDTO.thumb,
                floorPrice: nftDTO.data.floorPrice,
                changeRate: nftDTO.data.floorPriceInUSD24hPercentageChange
            )
        }

        return TrendingEntity(coins: coinEntities, nfts: nftEntities)
    }
}

extension TrendingEntity {
    static var mockData: TrendingEntity {
        let coins: [TrendingCoinEntity] = [
            .init(
                id: "bitcoin",
                name: "Bitcoin",
                symbol: "BTC",
                marketCapRank: 1,
                thumb: "https://coin-images.coingecko.com/coins/images/1/small/bitcoin.png",
                price: "0.0952",
                changeRate: "-3.85"
            ),
            .init(
                id: "ethereum",
                name: "Ethereum",
                symbol: "ETH",
                marketCapRank: 2,
                thumb: "https://coin-images.coingecko.com/coins/images/279/small/ethereum.png",
                price: "2188.03",
                changeRate: "-1.05"
            ),
            .init(
                id: "solana",
                name: "Solana",
                symbol: "SOL",
                marketCapRank: 6,
                thumb: "https://coin-images.coingecko.com/coins/images/4128/small/solana.png",
                price: "0.0026",
                changeRate: "-4.81"
            ),
            .init(
                id: "ondo-finance",
                name: "Ondo",
                symbol: "ONDO",
                marketCapRank: 41,
                thumb: "https://coin-images.coingecko.com/coins/images/26580/small/ONDO.png",
                price: "0.9525",
                changeRate: "-9.09"
            ),
            .init(
                id: "the-open-network",
                name: "Toncoin",
                symbol: "TON",
                marketCapRank: 25,
                thumb: "https://coin-images.coingecko.com/coins/images/17980/small/photo_2024-09-10_17.09.00.jpeg",
                price: "2.9868",
                changeRate: "-2.51"
            ),
            .init(
                id: "zignaly",
                name: "ZIGChain",
                symbol: "ZIG",
                marketCapRank: 356,
                thumb: "https://coin-images.coingecko.com/coins/images/14796/small/zig.jpg",
                price: "0.09525",
                changeRate: "-2.48"
            )
        ]
        
        let nfts: [TrendingNFTEntity] = [
            .init(
                id: "wealthy-hypio-babies",
                name: "Wealthy Hypio Babies",
                symbol: "HYPIO",
                thumb: "https://coin-images.coingecko.com/nft_contracts/images/15671/standard/wealthy-hypio-babies.png",
                floorPrice: "1.09 ETH",
                changeRate: "21.54387552656127"
            ),
            .init(
                id: "the-band-bears",
                name: "Band Bears",
                symbol: "BANDB",
                thumb: "https://coin-images.coingecko.com/nft_contracts/images/3137/standard/the-band-bears.png",
                floorPrice: "11.11 ETH",
                changeRate: "17.14734634169384"
            ),
            .init(
                id: "moonbirds",
                name: "Moonbirds",
                symbol: "MOONBIRD",
                thumb: "https://coin-images.coingecko.com/nft_contracts/images/349/standard/moobirds.webp",
                floorPrice: "0.54 ETH",
                changeRate: "7.098650935295411"
            ),
            .init(
                id: "creepz-genesis",
                name: "Creepz by OVERLORD",
                symbol: "CBC",
                thumb: "https://coin-images.coingecko.com/nft_contracts/images/1326/standard/creepz-genesis.png",
                floorPrice: "2.09 ETH",
                changeRate: "3.885820610207682"
            ),
            .init(
                id: "claynosaurz",
                name: "Claynosaurz",
                symbol: "CLAYNOSAURZ",
                thumb: "https://coin-images.coingecko.com/nft_contracts/images/2446/standard/claynosaurz.gif",
                floorPrice: "16.50 SOL",
                changeRate: "2.594313916820804"
            ),
            .init(
                id: "celestine-sloth-society",
                name: "mfers",
                symbol: "MFER",
                thumb: "https://coin-images.coingecko.com/nft_contracts/images/312/standard/mfers.png",
                floorPrice: "0.47 ETH",
                changeRate: "21.54387552656127"
            )
        ]
        
        return TrendingEntity(coins: coins, nfts: nfts)
    }
}
