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
    

    var symbolsSubject = BehaviorSubject(value: ["":""])

    
    func fetchSymbolsFromApi () {
        ApiService.shared.getSymbols { result  in
            switch result {
            case.success(let symbols) :
                self.symbolsSubject.onNext(symbols.symbols)
            case.failure(let error) :
                print(error.localizedDescription)
            }
            
        }
    }
 
}
