//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Jason Hung on 2024/6/9.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
