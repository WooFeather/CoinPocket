//
//  StarButton.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import SwiftUI

struct StarButton: View {
    var body: some View {
        Image(systemName: "star")
            .resizable()
            .frame(width: 20, height: 20)
            .tint(.purple)
            .wrapToButton {
                // TODO: 즐겨찾기 로직
            }
    }
}
