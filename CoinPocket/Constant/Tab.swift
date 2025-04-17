//
//  Tab.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import Foundation

enum Tab: Identifiable, CaseIterable {
    case trending
    case search
    case favorite
    case profile
    
    var id: UUID {
        return .init()
    }
    
    var icon: String {
        switch self {
        case .trending:
            return "chart.line.uptrend.xyaxis"
        case .search:
            return "magnifyingglass"
        case .favorite:
            return "wallet.bifold"
        case .profile:
            return "person"
        }
    }
}
