//
//  Sections.swift
//  Currency
//
//  Created by MacBook on 31/10/2022.
//

import Foundation
import RxSwift
import RxDataSources

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}
extension SectionOfCustomData: SectionModelType {
    typealias Item = ConverterModel
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
