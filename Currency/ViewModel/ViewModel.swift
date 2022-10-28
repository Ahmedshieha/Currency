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
    
    var amountTextFieldBehavior = BehaviorRelay<String>(value:"")
    
    var labelSubject = BehaviorRelay<Double>(value: 0.0)
    
//    var lableObserver : Observable<Double> {
//        return labelSubject
//    }
        func fetchSymbolsFromApi () {
        ApiService.shared.getSymbolsWithMoya { result  in
            switch result {
            case.success(let symbols) :
//                guard let symbols = symbols else {return}
                let keysArray = Array(symbols.keys)
                self.symbolsSubject.accept(keysArray)
            case.failure(let error) :
                print(error.localizedDescription)
            }
            
        }
    }
    
    func convertCurrency () {
        ApiService.shared.convertCurrency(amount: Int(amountTextFieldBehavior.value) ?? 0, from: "USD", to: "EGP") { result in
            switch result {
            case.success(let converter) :
                self.labelSubject.accept(converter.result)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
 
}
