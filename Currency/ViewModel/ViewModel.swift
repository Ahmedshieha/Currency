//
//  ViewModel.swift
//  Currency
//
//  Created by MacBook on 28/10/2022.
//

import Foundation
import RxSwift
import RxCocoa
class SymbolViewModel {
    

    var symbolsSubject = BehaviorRelay<[String]>(value: [""])
    
    var fromTextFieldBehavior = BehaviorRelay<String>(value:"")
    var toTextFieldBehavior = BehaviorRelay<String>(value:"")
    var resultSubject = BehaviorRelay<String>(value: "")
    
    var fromPickerViewBehavior = BehaviorRelay<String>(value: "")
    var toPickerViewBehavior = BehaviorRelay<String>(value: "")
     

    
    
        func fetchSymbolsFromApi () {
        ApiService.shared.getSymbolsWithMoya { result  in
            switch result {
            case.success(let symbols) :
                let keysArray = Array(symbols.keys)
                self.symbolsSubject.accept(keysArray)
            case.failure(let error) :
                print(error.localizedDescription)
            }
            
        }
    }
    
    func convertCurrencyFromTo () {
       
        ApiService.shared.convertCurrency(amount: Int(fromTextFieldBehavior.value) ?? 0, from: fromPickerViewBehavior.value, to: toPickerViewBehavior.value) { result in
            switch result {
            case.success(let converter) :
                self.resultSubject.accept(String(converter.result))
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }

 
}
