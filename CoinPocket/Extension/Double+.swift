//
//  Double+.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import SwiftUI

extension Double {
    var asPriceString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 4
        formatter.maximumFractionDigits = 4
        return formatter.string(from: .init(value: self)) ?? "$0.0000"
    }

    var asChangeRateString: String {
        let percent = self * 100
        let sign = percent >= 0 ? "+" : "-"
        let absValue = abs(percent)

        let formatter = NumberFormatter()
        formatter.numberStyle           = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let numStr = formatter.string(from: .init(value: absValue)) ?? "0.00"
        return "\(sign)\(numStr)%"
    }

    var percentColor: Color {
        self < 0 ? .blue : .red
    }
}
