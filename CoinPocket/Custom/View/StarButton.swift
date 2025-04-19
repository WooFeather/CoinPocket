//
//  StarButton.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import SwiftUI
import RealmSwift

struct StarButton: View {
    @ObservedResults(FavoriteObject.self) private var favorites
    private var repository = RealmRepository.shared
    let coinId: String
    
    /// 상황별 토스트 메시지 전달용
    var onResult: ((StarActionResult) -> Void)? = nil
    
    enum StarActionResult {
        case added, removed, limitReached
    }

    init(coinId: String, onResult: ((StarActionResult) -> Void)? = nil) {
        self.coinId = coinId
        self.onResult = onResult
    }
    
    private var isFavorite: Bool {
        favorites.contains(where: { $0.id == coinId })
    }
    
    var body: some View {
        Image(systemName: isFavorite ? "star.fill" : "star")
            .resizable()
            .frame(width: 20, height: 20)
            .tint(.purple)
            .wrapToButton {
                toggleFavorite()
            }
    }
    
    // MARK: - Action
    private func toggleFavorite() {
        if isFavorite {
            repository.delete(by: coinId)
            onResult?(.removed)
        } else if favorites.count < 10 {
            let obj = FavoriteObject(value: ["id": coinId])
            repository.save(obj)
            onResult?(.added)
        } else {
            onResult?(.limitReached)
        }
    }
}
