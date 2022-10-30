//
//  OtherCurrenciesViewModel.swift
//  Currency
//
//  Created by MacBook on 30/10/2022.
//

import Foundation
import RxCocoa
import RxSwift

class OtherCurrenciesViewModel {
    
    var transactionSubject = BehaviorRelay<[String:Double]>(value: ["":0.0])
    var otherCurrencies = PublishSubject<[String]>()
    var fromPickerViewBehavior = BehaviorRelay<String>(value: "")
    
    
    func getOtherCurrencies() {
        let popularCurrencies = ["USD", "EUR", "JPY", "GBP", "AUD", "CAD", "CHF", "CNH", "HKD","NZD"]
        ApiService.shared.otherCurrencies(base: UserDefaults.standard.value(forKey: "base") as! String, symbols: commaSeparatedList(list: popularCurrencies) ) { result in
            switch result {
            case.success(let otherCurrencies) :
                self.transactionSubject.accept(otherCurrencies.rates)
            case.failure(let error ):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func commaSeparatedList(list: [String]) -> String {
        var outputString: String = ""
        for element in list {
            outputString.append(element + ",")
        }
        outputString.removeLast()
        return outputString
    }
    

}

extension BehaviorRelay where Element: RangeReplaceableCollection {

    func add(element: Element.Element) {
        var array = self.value
        array.append(element)
        self.accept(array)
    }
}
