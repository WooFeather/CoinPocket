//
//  SearchView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/17/25.
//

import SwiftUI
import AlertToast

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var showToast = false
    @State private var toastMsg = ""
    
    var body: some View {
        NavigationWrapper {
            searchScrollView()
                .searchable(text: $viewModel.input.query, placement: .navigationBarDrawer, prompt: "코인명을 입력하세요")
                .onSubmit(of: .search) {
                    viewModel.action(.search)
                }
                .navigationTitle("Search")
                .navigationBar { } trailing: {
                    ProfileImageButton()
                }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .hud, type: .regular, title: toastMsg)
        }
    }
    
    // MARK: - Function
    @ViewBuilder
    private func searchScrollView() -> some View {
        if viewModel.output.isLoading {
            ProgressView()
        } else if viewModel.output.results.isEmpty {
            Text("검색 결과가 없습니다.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.output.results, id: \.id) { item in // TODO: 검색어랑 일치하는 Text 하이라이트 처리
                        NavigationLink {
                            LazyView(DetailView(coinId: item.id))
                        } label: {
                            searchRowView(entity: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical)
            }
        }
    }
    
    private func searchRowView(entity: SearchCoinEntity) -> some View {
        
        let errorImage = Image(systemName: "exclamationmark.triangle")
        
        return HStack {
            AsyncImage(url: URL(string: entity.thumb)) { data in
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
                highlightedText(entity.name, query: viewModel.input.query)
                    .font(.body.bold())
                    .lineLimit(1)
                Text(entity.symbol)
                    .font(.callout)
            }
            
            Spacer()
            
            StarButton(coinId: entity.id) { result in
                switch result {
                case .added:
                    toastMsg = "즐겨찾기에 추가되었습니다."
                case .removed:
                    toastMsg = "즐겨찾기에서 삭제되었습니다."
                case .limitReached:
                    toastMsg = "즐겨찾기는 최대 10개까지 등록 가능합니다."
                }
                showToast = true
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .contentShape(Rectangle())
    }
    
    private func highlightedText(_ text: String, query: String) -> Text {
        guard !query.isEmpty else { return Text(text) }
        
        var attr = AttributedString(text)
        if let range = attr.range(of: query, options: .caseInsensitive) {
            attr[range].foregroundColor = .purple
            attr[range].font = .body.bold()
        }
        return Text(attr)
    }
}

#Preview {
    SearchView()
}
