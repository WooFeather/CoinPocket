//
//  FavoriteView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

struct FavoriteView: View {
    var body: some View {
        NavigationWrapper {
            favoriteScrollView()
                .navigationTitle("Favorite")
                .navigationBar { } trailing: {
                    ProfileImageButton()
                }
        }
    }
    
    // MARK: - Function
    private func favoriteScrollView() -> some View {
        let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<10) { _ in
                    NavigationLink {
//                        LazyView(DetailView(coinId: <#String#>))
                    } label: {
                        favoriteRowView()
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
    
    private func favoriteRowView() -> some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
                .shadow(radius: 1)
            
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
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("+0.64%")
                    .font(.footnote.bold())
                    .foregroundStyle(.red)
                    .padding(4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.red.opacity(0.2))
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
