//
//  DetailView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import SwiftUI
import Charts

struct DetailView: View {
    @StateObject private var viewModel = DetailViewModel()
    
    var coinId: String
    
    var body: some View {
        ScrollView {
            if viewModel.output.isLoading {
                ProgressView()
            } else {
                coinInfoView(entity: viewModel.output.coinDetail)
                priceInfoView(entity: viewModel.output.coinDetail)
                chartView(entity: viewModel.output.coinDetail)
            }
        }
        .onAppear {
            viewModel.action(.getCoinId(coinId))
        }
        .navigationBar { } trailing: {
            StarButton(coinId: coinId)
        }
    }
    
    // MARK: - Function
    private func coinInfoView(entity: MarketEntity) -> some View {
        let errorImage = Image(systemName: "exclamationmark.triangle")
        
        return LazyVStack(alignment: .leading) {
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
                
                Text(entity.name)
                    .font(.largeTitle.bold())
            }
            
            Text(entity.currentPrice.asWonString)
                .font(.largeTitle.bold())
            
            HStack {
                Text(entity.priceChangePercentage24h?.asChangeRateString ?? "-1")
                    .foregroundStyle(entity.priceChangePercentage24h?.percentColor ?? .black)
                Text("Today")
                    .foregroundStyle(.gray)
            }
        }
        .padding()
    }
    
    private func priceInfoView(entity: MarketEntity) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                priceView("고가", titleColor: .red, price: entity.high24h?.asWonString ?? "")
                priceView("신고점", titleColor: .red, price: entity.ath.asWonString)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                priceView("저가", titleColor: .blue, price: entity.low24h?.asWonString ?? "")
                priceView("신저점", titleColor: .blue, price: entity.atl.asWonString)
            }
            Spacer()
        }
        .padding()
    }
    
    private func priceView(_ title: String, titleColor: Color ,price: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .foregroundStyle(titleColor)
            
            Text(price)
                .foregroundStyle(.gray)
        }
    }
    
    private func chartView(entity: MarketEntity) -> some View {
        LazyVStack(alignment: .trailing) {
            SparklineChart(entity: entity)
            
            Text(entity.lastUpdated.toDate?.toString(dateFormat: "M/d HH:mm:ss 업데이트") ?? "")
                .font(.caption)
                .foregroundStyle(.gray)
                .padding()
        }
    }
}

// MARK: - ChartView
struct SparklineChart: View {
    let entity: MarketEntity
    private let purple = Color.purple
    
    var body: some View {
        Chart {
            ForEach(entity.sparklinePoints) { point in
                AreaMark(
                    x: .value("Index", point.id),
                    y: .value("Price", point.price)
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            purple.opacity(0.4),
                            purple.opacity(0.6),
                            purple
                        ],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
            }
            
            ForEach(entity.sparklinePoints) { point in
                LineMark(
                    x: .value("Index", point.id),
                    y: .value("Price", point.price)
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
                .foregroundStyle(purple)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(height: 300)
        .mask(
            LinearGradient(
                colors: [.black, .black, .clear],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

//#Preview {
//    DetailView(coinId: "Bitcoin Cash")
//}
