//
//  Symbols.swift
//  Currency
//
//  Created by MacBook on 28/10/2022.
//

import Foundation

struct Welcome: Codable {
    let success: Bool
    let symbols: [String: String]
}
