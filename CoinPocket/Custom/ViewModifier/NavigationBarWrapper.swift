//
//  NavigationBarWrapper.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

private struct NavigationBarWrapper<Leading: View, Trailing: View>: ViewModifier {
    let leading: Leading
    let trailing: Trailing
    
    init(
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content
                .toolbar {
                    ToolbarItem(
                        placement: .topBarLeading,
                        content: { leading }
                    )
                    
                    ToolbarItem(
                        placement: .topBarTrailing,
                        content: { trailing }
                    )
                }
        } else {
            content
                .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
}

extension View {
    func navigationBar(
        @ViewBuilder leading: () -> some View,
        @ViewBuilder trailing: () -> some View
    ) -> some View {
        modifier(NavigationBarWrapper(leading: leading, trailing: trailing))
    }
}
