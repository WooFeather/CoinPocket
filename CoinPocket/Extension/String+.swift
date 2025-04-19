//
//  String+.swift
//  CoinPocket
//
//  Created by 조우현 on 4/19/25.
//

import Foundation

extension String {
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
}
