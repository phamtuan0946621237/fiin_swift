//
//  StringExtensions.swift
//  fiin_swift
//
//  Created by admin on 3/19/21.
//

import Foundation

extension Int {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter
    }()

    var toAmount: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
