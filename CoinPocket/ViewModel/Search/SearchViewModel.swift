//
//  SearchViewModel.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation
import Combine

final class SearchViewModel: ViewModelType {
    private let repository: CoingeckoRepositoryType
    
    var input = Input()
    @Published var output = Output()
    var cancellables = Set<AnyCancellable>()
    
    init(repository: CoingeckoRepositoryType = CoingeckoRepository.shared) {
        self.repository = repository
        transform()
    }
    
    struct Input {
        var query: String = ""
        let searchTapped = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var results: [SearchCoinEntity] = []
        var isLoading: Bool = false
    }
}

// MARK: - Action
extension SearchViewModel {
    enum Action {
        case search
    }
    
    func action(_ action: Action) {
        switch action {
        case .search:
            input.searchTapped.send(())
        }
    }
}

// MARK: - Transform
extension SearchViewModel {
    func transform() {
        input.searchTapped
            .map { [weak self] in
                self?.input.query.trimmingCharacters(in: .whitespaces) ?? ""
            }
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink { [weak self] query in
                guard let self = self else { return }
                Task { await self.performSearch(for: query) }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Function
@MainActor
extension SearchViewModel {
    func performSearch(for query: String) async {
        output.isLoading = true
        
        do {
            let response = try await repository.search(query)
            output.results = response.coins
        } catch {
            output.results = []
            print("Search error:", error)
        }
        
        output.isLoading = false
    }
}
