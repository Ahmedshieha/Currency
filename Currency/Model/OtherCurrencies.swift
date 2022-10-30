//
//  OtherCurrencies.swift
//  Currency
//
//  Created by MacBook on 30/10/2022.
//

import Foundation

struct OtherCurrencies: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}
