//
//  TrendingView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

struct TrendingView: View {
    
    @StateObject private var viewModel = TrendingViewModel()
    
    var body: some View {
        NavigationWrapper {
            ScrollView(showsIndicators: false) {
                favoriteView()
                rankingView(title: "Top 15 Coin", isCoin: true)
                rankingView(title: "Top 7 NFT", isCoin: false)
            }
            .onAppear {
                viewModel.action(.fetchTrendingData)
                viewModel.action(.fetchFavoriteData)
            }
            .navigationTitle("CoinPocket")
            .navigationBar { } trailing: {
                ProfileImageButton()
            }
        }
        .tint(.purple)
    }
    
    // MARK: - Function
    @ViewBuilder
    private func favoriteView() -> some View {
        // 2개 미만 + 아직 로딩 중이 아닐 때 → 아무것도 안 그린다
        if viewModel.output.isFavoriteLoading ||
            viewModel.output.favorites.count >= 2 {
            
            VStack {
                Text("My Favorite")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if viewModel.output.isFavoriteLoading {
                    ProgressView()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.output.favorites, id: \.id) { item in
                                NavigationLink {
                                    LazyView(DetailView(coinId: item.id))
                                } label: {
                                    favoriteRowView(entity: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    private func rankingView(title: String, isCoin: Bool) -> some View {
        let rows = Array(repeating: GridItem(.fixed(68)), count: 3)
        
        return VStack {
            Text(title)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            if viewModel.output.isRankingLoading {
                ProgressView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows) {
                        if isCoin {
                            ForEach(Array(viewModel.output.coins.enumerated()), id: \.element.id) { index, item in
                                NavigationLink {
                                    LazyView(DetailView(coinId: item.id))
                                } label: {
                                    rankingRowView(
                                        rank: index + 1,
                                        thumbImage: item.thumb,
                                        name: item.name,
                                        symbol: item.symbol,
                                        price: item.price.asPriceString,
                                        changeRate: item.changeRate
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        } else {
                            ForEach(Array(viewModel.output.nfts.enumerated()), id: \.element.id) { index, item in
                                rankingRowView(
                                    rank: index + 1,
                                    thumbImage: item.thumb,
                                    name: item.name,
                                    symbol: item.symbol,
                                    price: item.floorPrice,
                                    changeRate: item.changeRate
                                )
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom)
    }
    
    private func favoriteRowView(entity: MarketEntity) -> some View {
        let errorImage = Image(systemName: "exclamationmark.triangle")
        
        return ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(.gray.opacity(0.2))
            
            VStack(alignment: .leading) {
                HStack {
                    AsyncImage(url: URL(string: entity.image)) { data in
                        switch data {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                        case .failure(_):
                            errorImage
                        @unknown default:
                            errorImage
                        }
                    }
                    .frame(width: 30, height: 30)
                    
                    VStack(alignment: .leading) {
                        Text(entity.name)
                            .font(.headline)
                        Text(entity.symbol)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                
                Text(entity.currentPrice.asWonString)
                    .font(.body.bold())
                Text(entity.priceChangePercentage24h?.asChangeRateString ?? "-1")
                    .font(.callout.bold())
                    .foregroundStyle(.red)
            }
            .padding()
        }
        .frame(width: 220, height: 150)
    }
    
    private func rankingRowView(rank: Int, thumbImage: String, name: String, symbol: String, price: String, changeRate: Double) -> some View {
        let errorImage = Image(systemName: "exclamationmark.triangle")
        
        return VStack {
            HStack {
                Text("\(rank)")
                    .font(.title3.bold())
                
                AsyncImage(url: URL(string: thumbImage)) { data in
                    switch data {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                    case .failure(_):
                        errorImage
                    @unknown default:
                        errorImage
                    }
                }
                .frame(width: 30, height: 30)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.body.bold())
                    Text(symbol)
                        .font(.callout)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(price)
                        .font(.body)
                    
                    Text(changeRate.asChangeRateString)
                        .font(.caption)
                        .foregroundStyle(changeRate.percentColor)
                }
            }
            Divider()
        }
        .frame(width: 320)
        .padding(.horizontal)
        .contentShape(Rectangle())
    }
}

//#Preview {
//    TrendingView()
//}
