//
//  ProfileImageView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

struct ProfileImageButton: View {
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .asCircleImage()
            .wrapToButton {
                // TODO: ProfileView로 이동
            }
            .buttonStyle(.plain)
    }
}
