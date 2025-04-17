//
//  SearchView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationWrapper {
            searchScrollView()
                .navigationTitle("Search")
                .navigationBar { } trailing: {
                    ProfileImageButton()
                }
        }
    }
    
    // MARK: - Function
    private func searchScrollView() -> some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<10) { item in
                    searchRowView()
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "코인명을 입력하세요")
    }
    
    private func searchRowView() -> some View {
        HStack {
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
            
            StarButton()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}

#Preview {
    SearchView()
}
