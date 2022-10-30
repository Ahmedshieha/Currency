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
    
    
    // method to fetch  available currencies from ApiService and retrieve array of symbols as [string]
    
        func fetchSymbolsFromApi () {
            loadingBehavior.accept(true)
        ApiService.shared.getSymbolsWithMoya {[weak self] result  in
            guard let self = self else {return}
            switch result {
            case.success(let symbols) :
                let keysArray = Array(symbols.keys)
                self.symbolsSubject.accept(keysArray)
                self.loadingBehavior.accept(false)
            case.failure(let error) :
                print(error.localizedDescription)
            }
            
        }
    }
    // method to get result of convert currencies from ApiService
    
    func convertCurrencyFromTo () {
        loadingBehavior.accept(true)
        ApiService.shared.convertCurrency(amount: Int(fromTextFieldBehavior.value) ?? 0, from: fromPickerViewBehavior.value, to: toPickerViewBehavior.value) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case.success(let converter) :
                self.loadingBehavior.accept(false)
                self.resultSubject.accept(String(converter.result))
                // save user action to pass it in othercurrencies page
                UserDefaults.standard.set(converter.query.from, forKey: "base")
                UserDefaults.standard.set(converter.query.amount, forKey: "amount")
                // save data in coreData after convert success
                self.historyViewModel.saveToCoreData(date: converter.date, amount: Int32(converter.query.amount), from: converter.query.from, to: converter.query.to, result: converter.result)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
  
    
    
    
    
}


