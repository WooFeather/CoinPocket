//
//  TrendingView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

struct TrendingView: View {
    var body: some View {
        NavigationWrapper {
            ScrollView(showsIndicators: false) {
                favoriteView()
                rankingView(title: "Top 15 Coin")
                rankingView(title: "Top 7 NFT")
            }
            .navigationTitle("CoinPocket")
            .navigationBar { } trailing: {
                ProfileImageButton()
            }
        }
        .tint(.purple)
    }
    
    // MARK: - Function
    private func favoriteView() -> some View {
        VStack {
            Text("My Favorite")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<5) { item in
                        NavigationLink {
                            LazyView(DetailView())
                        } label: {
                            favoriteRowView()
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    // Coin과 NFT에 재사용
    private func rankingView(title: String) -> some View {
        let rows = [
            GridItem(.fixed(68)),
            GridItem(.fixed(68)),
            GridItem(.fixed(68))
        ]
        
        return VStack {
            Text(title)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows) {
                    ForEach(0..<9) { item in
                        NavigationLink {
                            LazyView(DetailView())
                        } label: {
                            rankingRowView()
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(.bottom)
    }
    
    private func favoriteRowView() -> some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(.gray.opacity(0.2))
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .asCircleImage()
                    
                    VStack(alignment: .leading) {
                        Text("Bitcoin")
                            .font(.headline)
                        Text("BTC")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                
                Text("CurrentPrice")
                    .font(.body.bold())
                Text("priceChangeRate")
                    .font(.callout.bold())
                    .foregroundStyle(.red)
            }
            .padding()
        }
        .frame(width: 220, height: 150)
    }
    
    private func rankingRowView() -> some View {
        VStack {
            HStack {
                Text("1")
                    .font(.title3.bold())
                
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.body.bold())
                    Text("symbol")
                        .font(.callout)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Price")
                        .font(.body)
                    
                    Text("priceChangeRate")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            Divider()
        }
        .frame(width: 320)
        .padding(.horizontal)
        .contentShape(Rectangle())
    }
}

#Preview {
    TrendingView()
}
