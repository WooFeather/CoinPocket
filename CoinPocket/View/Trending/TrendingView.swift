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
                favoriteView() // TODO: 즐겨찾기가 2개 이상이면 표시
                rankingView(title: "Top 15 Coin", isCoin: true)
                rankingView(title: "Top 7 NFT", isCoin: false)
            }
            .onAppear {
                viewModel.action(.fetchTrendingData)
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
                            // LazyView(DetailView())
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
    
    private func rankingView(title: String, isCoin: Bool) -> some View {
        let rows = Array(repeating: GridItem(.fixed(68)), count: 3)
        
        return VStack {
            Text(title)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            if viewModel.output.isLoading {
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
