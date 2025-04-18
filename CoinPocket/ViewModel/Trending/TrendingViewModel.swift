//
//  TrendingViewModel.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

@MainActor
final class TrendingViewModel: ObservableObject {
    @Published var coins: [TrendingCoinEntity] = []
    @Published var nfts: [TrendingNFTEntity] = []
    private let repository: CoingeckoRepositoryType = CoingeckoRepository.shared
    
    func fetchTrendingData() async {
        do {
            let response = try await repository.trending()
            coins = response.coins
            nfts = response.nfts
        } catch { // TODO: 에러처리
            coins = []
            nfts = []
            print(error)
        }
    }
}
