//
//  ViewModel.swift
//  Currency
//
//  Created by MacBook on 28/10/2022.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData
class HomeViewModel {
    

    var symbolsSubject = BehaviorRelay<[String]>(value: [""])
    
    var fromTextFieldBehavior = BehaviorRelay<String>(value:"")
    var toTextFieldBehavior = BehaviorRelay<String>(value:"")
    
    var resultSubject = BehaviorRelay<String>(value: "")
    
    var fromPickerViewBehavior = BehaviorRelay<String>(value: "")
    var toPickerViewBehavior = BehaviorRelay<String>(value: "")
     
    var loadingBehavior = BehaviorRelay<Bool>(value : false)
    
    
     let historyViewModel = HistoryViewModel()
        func fetchSymbolsFromApi () {
            loadingBehavior.accept(true)
        ApiService.shared.getSymbolsWithMoya {[weak self] result  in
            guard let self = self else {return}
            switch result {
            case.success(let symbols) :
                self.loadingBehavior.accept(false)
                let keysArray = Array(symbols.keys)
                self.symbolsSubject.accept(keysArray)
            case.failure(let error) :
                print(error.localizedDescription)
            }
            
        }
    }
    
    func convertCurrencyFromTo () {
        loadingBehavior.accept(true)
        ApiService.shared.convertCurrency(amount: Int(fromTextFieldBehavior.value) ?? 0, from: fromPickerViewBehavior.value, to: toPickerViewBehavior.value) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case.success(let converter) :
                self.loadingBehavior.accept(false)
                self.resultSubject.accept(String(converter.result))
                self.historyViewModel.saveToCoreData(date: converter.date, amount: Int32(converter.query.amount), from: converter.query.from, to: converter.query.to, result: converter.result)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
  
    
    
    
    
}


