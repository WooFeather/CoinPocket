//
//  MockRepository.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

final class MockRepository: CoingeckoRepositoryType {
    
    private let trendingMockData: TrendingEntity
    private let searchMockData: SearchEntity
    private let marketsMockData: [MarketEntity]
    
    init(
        trendingMockData: TrendingEntity = TrendingEntity.mockData,
        searchMockData: SearchEntity = SearchEntity.mockData,
        marketsMockData: [MarketEntity] = MarketEntity.mockData
    ) {
        self.trendingMockData = trendingMockData
        self.searchMockData = searchMockData
        self.marketsMockData = marketsMockData
    }
    
    func trending() async throws -> TrendingEntity {
        return trendingMockData
    }
    
    func markets(ids: [String]) async throws -> [MarketEntity] {
        return marketsMockData
    }
    
    func search(_ query: String) async throws -> SearchEntity {
        return searchMockData
    }
}
