//
//  CircleImageModifier.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

private struct CircleImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 36, height: 36)
            .background(.gray)
            .clipShape(Circle())
    }
}


extension View {
    func asCircleImage() -> some View {
        self.modifier(CircleImageModifier())
    }
}
