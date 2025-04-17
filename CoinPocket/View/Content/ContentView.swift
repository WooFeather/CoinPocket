//
//  ContentView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tab = .trending
    
    var body: some View {
        TabView {
            TrendingView()
                .asTabModifier(.trending)
            
            SearchView()
                .asTabModifier(.search)
            
            FavoriteView()
                .asTabModifier(.favorite)
            
            ProfileView()
                .asTabModifier(.profile)
        }
        .tint(.purple)
    }
}

#Preview {
    ContentView()
}
