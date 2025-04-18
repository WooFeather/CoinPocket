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
