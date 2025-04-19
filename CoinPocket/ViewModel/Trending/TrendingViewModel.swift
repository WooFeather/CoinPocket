//
//  TrendingViewModel.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation
import Combine

final class TrendingViewModel: ViewModelType {
    private let networkRepo: CoingeckoRepositoryType
    private let realmRepo: RealmRepositoryType
    var input = Input()
    @Published var output = Output()
    var cancellables = Set<AnyCancellable>()
    
    init(
        networkRepo: CoingeckoRepositoryType = CoingeckoRepository.shared,
        realmRepo: RealmRepositoryType = RealmRepository.shared
    ) {
        self.networkRepo = networkRepo
        self.realmRepo = realmRepo
        transform()
    }
    
    struct Input {
        let fetchTrendingData = PassthroughSubject<Void, Never>()
        let fetchFavoriteData = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var coins: [TrendingCoinEntity] = []
        var nfts: [TrendingNFTEntity] = []
        var favorites: [MarketEntity] = []
        var isRankingLoading: Bool = false
        var isFavoriteLoading: Bool = false
    }
}

// MARK: - Action
extension TrendingViewModel {
    enum Action {
        case fetchTrendingData
        case fetchFavoriteData
    }
    
    func action(_ action: Action) {
        switch action {
        case .fetchTrendingData:
            input.fetchTrendingData.send(())
        case .fetchFavoriteData:
            input.fetchFavoriteData.send(())
        }
    }
}

// MARK: - Tranform
extension TrendingViewModel {
    func transform() { // TODO: 10초마다 호출
        input.fetchTrendingData
            .sink { [weak self] _ in
                Task { await self?.fetchTrendingData() }
            }
            .store(in: &cancellables)
        
        input.fetchFavoriteData
            .sink { [weak self] _ in
                Task { await self?.loadFavorites() }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Function
@MainActor
extension TrendingViewModel {
    func fetchTrendingData() async {
        output.isRankingLoading = true
        
        do {
            let response = try await networkRepo.trending()
            output.coins = response.coins
            output.nfts = response.nfts
        } catch { // TODO: 에러처리
            output.coins = []
            output.nfts = []
            print(error)
        }
        
        output.isRankingLoading = false
    }
    
    func loadFavorites() async {
        output.isFavoriteLoading = true

        let ids = realmRepo.fetchAll().sorted(by: { $0.createdAt > $1.createdAt }).map(\.id)

        do {
            let result = try await networkRepo.markets(ids: ids)
            let sorted = ids.compactMap { id in
                result.first(where: { $0.id == id })
            }
            output.favorites = sorted
        } catch {
            print("❌ network error:", error)
        }

        output.isFavoriteLoading = false
    }
}
