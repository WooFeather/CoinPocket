//
//  FavoriteViewModel.swift
//  CoinPocket
//
//  Created by 조우현 on 4/19/25.
//

/*
 1. realm 트리거를 받으면 realm에서 전체 데이터를 fetch
 2. realm에서 불러온 id들로 markets 네트워크 통신
 3. 네트워크 통신 결과 배열을 view로 내보냄
 */

import Foundation
import Combine

final class FavoriteViewModel: ViewModelType {
    private let networkRepo: CoingeckoRepositoryType
    private let realmRepo: RealmRepositoryType
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    init(
        networkRepo: CoingeckoRepositoryType = CoingeckoRepository.shared,
        realmRepo: RealmRepositoryType = RealmRepository.shared
    ) {
        self.networkRepo = networkRepo
        self.realmRepo = realmRepo
        transform()
    }
    
    struct Input {
        let refresh = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var favorites: [MarketEntity] = []
        var isLoading: Bool = false
    }
    
    func transform() {
        input.refresh
            .sink { [weak self] _ in
                Task { await self?.loadFavorites() }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Action
extension FavoriteViewModel {
    enum Action {
        case fetchFavoriteData
    }
    
    func action(_ action: Action) {
        switch action {
        case .fetchFavoriteData:
            input.refresh.send(())
        }
    }
}

// MARK: - Function
extension FavoriteViewModel {
    @MainActor
    private func loadFavorites() async {
        output.isLoading = true

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

        output.isLoading = false
    }
}
