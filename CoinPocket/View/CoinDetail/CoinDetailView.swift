//
//  DetailView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import SwiftUI

struct CoinDetailView: View {
    var body: some View {
        ScrollView {
            Text("Detail")
        }
        .navigationBar { } trailing: {
            StarButton()
        }
    }
}

#Preview {
    CoinDetailView()
}
