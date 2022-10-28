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
    

    var symbolsSubject = PublishSubject<[String:String]>()
        func fetchSymbolsFromApi () {
        
        ApiService.shared.getSymbolsWithMoya { result  in
            switch result {
            case.success(let symbols) :
//                guard let symbols = symbols else {return}
                self.symbolsSubject.onNext(symbols)
//                print(symbols)
            case.failure(let error) :
                print(error.localizedDescription)
            }
            
        }
    }
 
}
