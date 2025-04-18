//
//  TrendingViewModel.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import SwiftUI

final class TrendingViewModel: ObservableObject {
    @Published var coins: [TrendingCoinEntity] = []
    @Published var nfts: [TrendingNFTEntity] = []
    private let repository: CoingeckoRepositoryType = CoingeckoRepository()
    
    func fetchTrendingData() async {
        do {
            coins = try await repository.trending().coins
            nfts = try await repository.trending().nfts
        } catch {
            coins = []
            nfts = []
            print(error)
        }
    }
}
