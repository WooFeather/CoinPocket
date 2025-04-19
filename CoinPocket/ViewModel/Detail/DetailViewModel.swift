//
//  DetailViewModel.swift
//  CoinPocket
//
//  Created by 조우현 on 4/19/25.
//

import Foundation
import Combine

final class DetailViewModel: ViewModelType {
    private let repository: CoingeckoRepositoryType
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    init(repository: CoingeckoRepositoryType = CoingeckoRepository.shared) {
        self.repository = repository
        transform()
    }
    
    struct Input {
        let coinId = PassthroughSubject<String, Never>()
        let fetchCoinDetail = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var coinDetail: MarketEntity = MarketEntity.mockData.first!
        var isLoading: Bool = false
    }
    
    func transform() {
        input.coinId
            .sink { [weak self] id in
                Task {
                    await self?.fetchCoinDetail(id: id)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Action
extension DetailViewModel {
    enum Action {
        case getCoinId(String)
        case fetchCoinDetail
    }
    
    func action(_ action: Action) {
        switch action {
        case .getCoinId(let id):
            input.coinId.send(id)
        case .fetchCoinDetail:
            input.fetchCoinDetail.send(())
        }
    }
}

// MARK: - Function
extension DetailViewModel {
    private func fetchCoinDetail(id: String) async {
        output.isLoading = true
        
        do {
            let response = try await repository.detail(id: id)
            output.coinDetail = response
        } catch { // TODO: 에러처리
            print(error)
        }
        
        output.isLoading = false
    }
}
