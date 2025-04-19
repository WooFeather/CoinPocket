//
//  Date+.swift
//  CoinPocket
//
//  Created by 조우현 on 4/19/25.
//

import Foundation

extension Date {
    func toString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
