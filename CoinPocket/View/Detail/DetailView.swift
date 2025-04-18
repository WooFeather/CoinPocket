//
//  DetailView.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import SwiftUI
import Charts

struct DetailView: View {
    var body: some View {
        ScrollView {
            coinInfoView()
            priceInfoView()
            chartView()
        }
        .navigationBar { } trailing: {
            StarButton()
        }
    }
    
    init() {
        print("DetailView init")
    }
    
    // MARK: - Function
    private func coinInfoView() -> some View {
        LazyVStack(alignment: .leading) {
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("CoinName")
                    .font(.largeTitle.bold())
            }
            
            Text("99,999,999")
                .font(.largeTitle.bold())
            
            HStack {
                Text("+9.99%")
                    .foregroundStyle(.red)
                Text("Today")
                    .foregroundStyle(.gray)
            }
        }
        .padding()
    }
    
    private func priceInfoView() -> some View {
        HStack {
            VStack(spacing: 20) {
                priceView("고가", titleColor: .red, price: "99,999,999")
                priceView("신고점", titleColor: .red, price: "99,999,999")
            }
            Spacer()
            VStack(spacing: 20) {
                priceView("저가", titleColor: .blue, price: "99,999,999")
                priceView("신저점", titleColor: .blue, price: "99,999,999")
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
    
    private func chartView() -> some View {
        LazyVStack(alignment: .trailing) {
            // Chart
            Text("2/21 88:88:88 업데이트")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding()
    }
}

#Preview {
    DetailView()
}
