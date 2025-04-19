//
//  CoingeckoRepository.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

protocol CoingeckoRepositoryType {
    func trending() async throws -> TrendingEntity
    func markets(ids: [String]) async throws -> [MarketEntity]
    func search(_ query: String) async throws -> SearchEntity
}

final class CoingeckoRepository: CoingeckoRepositoryType {
    static let shared: CoingeckoRepositoryType = CoingeckoRepository()
    private let networkManager: NetworkManagerType = NetworkManager.shared
    
    private init() { }
    
    func trending() async throws -> TrendingEntity {
        do {
            let result: TrendingDTO = try await networkManager.fetchData(CoingeckoRouter.trending)
            return result.toEntity()
        } catch {
            print("error: \(error)")
            throw error
        }
    }
    
    func markets(ids: [String]) async throws -> [MarketEntity] {
        let dtos: [MarketDTO] = try await networkManager.fetchData(
            CoingeckoRouter.markets(ids: ids)
        )
        return dtos.map { $0.toEntity() }
    }
    
    func search(_ query: String) async throws -> SearchEntity {
        do {
            let result: SearchDTO = try await networkManager.fetchData(CoingeckoRouter.search(query: query))
            return result.toEntity()
        } catch {
            print("error: \(error)")
            throw error
        }
    }
}

extension CoingeckoRepositoryType {
    func detail(id: String) async throws -> MarketEntity {
        guard let first = try await markets(ids: [id]).first else {
            throw NetworkError.unknown
        }
        return first
    }
}
