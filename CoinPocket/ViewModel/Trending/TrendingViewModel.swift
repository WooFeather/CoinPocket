//
//  TrendingViewModel.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation
import Combine

final class TrendingViewModel: ViewModelType {
    private let repository: CoingeckoRepositoryType
    var input = Input()
    @Published var output = Output()
    var cancellables = Set<AnyCancellable>()
    
    init(repository: CoingeckoRepositoryType = CoingeckoRepository.shared) {
        self.repository = repository
        transform()
    }
    
    struct Input {
        let fetchTrendingData = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var coins: [TrendingCoinEntity] = []
        var nfts: [TrendingNFTEntity] = []
        var isLoading: Bool = false
    }
}

// MARK: - Action
extension TrendingViewModel {
    enum Action {
        case fetchTrendingData
    }
    
    func action(_ action: Action) {
        switch action {
        case .fetchTrendingData:
            input.fetchTrendingData.send(())
        }
    }
}

// MARK: - Tranform
extension TrendingViewModel {
    func transform() {
        input.fetchTrendingData
            .sink { [weak self] _ in
                Task { await self?.fetchTrendingData() }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Function
@MainActor
extension TrendingViewModel {
    func fetchTrendingData() async {
        output.isLoading = true
        
        do {
            let response = try await repository.trending()
            output.coins = response.coins
            output.nfts = response.nfts
        } catch { // TODO: 에러처리
            output.coins = []
            output.nfts = []
            print(error)
        }
        
        output.isLoading = false
    }
}
