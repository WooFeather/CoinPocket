//
//  ContentView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var networkMonitor = NetworkMonitor.shared
    @State private var showAlert = false
    @State private var selectedTab: Tab = .trending
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TrendingView(selectedTab: $selectedTab)
                .asTabModifier(.trending)
            
            SearchView()
                .asTabModifier(.search)
            
            FavoriteView()
                .asTabModifier(.favorite)
            
            ProfileView()
                .asTabModifier(.profile)
        }
        .tint(.purple)
        .onReceive(networkMonitor.$isConnected) { isConnected in
            showAlert = !isConnected
        }
        .alert("네트워크 연결이 끊겼습니다. Wifi나 셀룰러 데이터를 확인해주세요.", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        }
    }
}

#Preview {
    ContentView()
}
