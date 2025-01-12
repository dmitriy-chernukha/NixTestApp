//
//  NumberFormatter.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import Foundation

extension NumberFormatter {
    convenience init(locale: Locale) {
        self.init()
        self.numberStyle = .currency
        self.locale = locale
    }
    
    func formattedAmount(_ amount: Int, currencyCode: String? = "EUR") -> String? {
        guard let currencyCode else { return "" }
        self.currencyCode = currencyCode
        self.maximumFractionDigits = 0
        self.minimumFractionDigits = 0
        
        return string(from: NSNumber(value: amount))
    }
}
