//
//  TrendingViewModel.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import SwiftUI

@MainActor
final class TrendingViewModel: ObservableObject {
    @Published var coins: [TrendingCoinEntity] = []
    @Published var nfts: [TrendingNFTEntity] = []
    private let repository: CoingeckoRepositoryType = CoingeckoRepository()
    
    func fetchTrendingData() async {
        do {
            let response = try await repository.trending()
            coins = response.coins
            nfts = response.nfts
        } catch {
            coins = []
            nfts = []
            print(error)
        }
    }
}
