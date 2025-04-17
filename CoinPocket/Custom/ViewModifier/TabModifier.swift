//
//  TabModifier.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

private struct TabModifier: ViewModifier {
    
    let selectedTab: Tab
    
    func body(content: Content) -> some View {
        content
            .tag(selectedTab)
            .tabItem {
                Image(systemName: selectedTab.icon)
            }
    }
}

extension View {
    func asTabModifier(_ selectedTab: Tab) -> some View {
        modifier(TabModifier(selectedTab: selectedTab))
    }
}
