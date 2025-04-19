//
//  RealmRepository.swift
//  CoinPocket
//
//  Created by 조우현 on 4/19/25.
//

import Foundation
import RealmSwift

protocol RealmRepositoryType {
    func getFileURL()
    func fetchAll() -> [FavoriteObject]
    func save(_ favorite: FavoriteObject)
    func delete(by id: String)
}

final class RealmRepository: RealmRepositoryType {
    static let shared = RealmRepository()
    private let realm = try! Realm()
    
    private init() { }
    
    func getFileURL() {
        print(realm.configuration.fileURL ?? "URL 찾을 수 없음")
    }
    
    func fetchAll() -> [FavoriteObject] {
        Array(realm.objects(FavoriteObject.self))
    }
    
    func save(_ favorite: FavoriteObject) {
        do {
            try realm.write {
                realm.add(favorite, update: .modified)
            }
        } catch {
            print("❌ Realm save 오류:", error)
        }
    }
    
    func delete(by id: String) {
        guard let object = realm.object(ofType: FavoriteObject.self, forPrimaryKey: id) else { return }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("❌ Realm delete 오류:", error)
        }
    }
}
