//
//  FavoriteView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

/*
 1. 뷰가 보여질때 realm을 fetch하는 트리거 전달
 2. viewModel에서 나온 네트워크 결과 배열을 favoriteScrollView에 보여줌
 */

import SwiftUI

struct FavoriteView: View {
    
    @StateObject private var viewModel = FavoriteViewModel()
    
    var body: some View {
        NavigationWrapper {
            favoriteScrollView()
                .navigationTitle("Favorite")
                .navigationBar { } trailing: {
                    ProfileImageButton()
                }
        }
        .onAppear {
            viewModel.action(.fetchFavoriteData)
        }
    }
    
    // MARK: - Function
    private func favoriteScrollView() -> some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.output.favorites, id: \.id) { item in
                    NavigationLink {
                        LazyView(DetailView(coinId: item.id))
                    } label: {
                        favoriteRowView(entity: item)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
    
    private func favoriteRowView(entity: MarketEntity) -> some View {
        let errorImage = Image(systemName: "exclamationmark.triangle")
        
        return ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
                .shadow(radius: 1)
            
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
                            .font(.body)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                
                Text(entity.currentPrice.asWonString)
                    .font(.body.bold())
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text(entity.priceChangePercentage24h?.asChangeRateString ?? "-1")
                    .font(.footnote.bold())
                    .foregroundStyle(entity.priceChangePercentage24h?.percentColor ?? .black)
                    .padding(4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(entity.priceChangePercentage24h?.percentColor.opacity(0.2) ?? .black.opacity(0.2))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
    }
}

#Preview {
    FavoriteView()
}
