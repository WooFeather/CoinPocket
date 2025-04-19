//
//  FavoriteObject.swift
//  CoinPocket
//
//  Created by 조우현 on 4/19/25.
//

import Foundation
import RealmSwift

final class FavoriteObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var createdAt: Date = Date()
}
