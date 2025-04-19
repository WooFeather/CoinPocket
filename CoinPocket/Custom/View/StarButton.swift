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
    
    init(coinId: String) {
        repository.getFileURL()
        self.coinId = coinId
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
        } else {
            let obj = FavoriteObject(value: ["id": coinId])
            repository.save(obj)
        }
    }
}
