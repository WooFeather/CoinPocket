//
//  SearchEntity.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

struct SearchEntity {
    let coins: [SearchCoinEntity]
}

struct SearchCoinEntity {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
}

extension SearchDTO {
    func toEntity() -> SearchEntity {
        SearchEntity(coins: self.coins.map {
            return SearchCoinEntity(
                id: $0.id,
                name: $0.name,
                symbol: $0.symbol,
                thumb: $0.thumb
            )
        })
    }
}

extension SearchEntity {
    static var mockData: SearchEntity {
        let sampleCoins: [SearchCoinEntity] = [
            SearchCoinEntity(
                id: "bitcoin",
                name: "Bitcoin",
                symbol: "BTC",
                thumb: "https://coin-images.coingecko.com/coins/images/1/thumb/bitcoin.png"
            ),
            SearchCoinEntity(
                id: "wrapped-bitcoin",
                name: "Wrapped Bitcoin",
                symbol: "WBTC",
                thumb: "https://coin-images.coingecko.com/coins/images/7598/thumb/wrapped_bitcoin_wbtc.png"
            ),
            SearchCoinEntity(
                id: "bitcoin-cash",
                name: "Bitcoin Cash",
                symbol: "BCH",
                thumb: "https://coin-images.coingecko.com/coins/images/780/thumb/bitcoin-cash-circle.png"
            ),
            SearchCoinEntity(
                id: "bitcoin-cash-sv",
                name: "Bitcoin SV",
                symbol: "BSV",
                thumb: "https://coin-images.coingecko.com/coins/images/6799/thumb/BSV.png"
            ),
            SearchCoinEntity(
                id: "dog-go-to-the-moon-rune",
                name: "Dog (Bitcoin)",
                symbol: "DOG",
                thumb: "https://coin-images.coingecko.com/coins/images/37352/thumb/DOGGOTOTHEMOON.png"
            )
        ]
        
        return SearchEntity(coins: sampleCoins)
    }
}
