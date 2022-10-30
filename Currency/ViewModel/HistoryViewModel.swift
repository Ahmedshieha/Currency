//
//  HistoryViewModel.swift
//  Currency
//
//  Created by MacBook on 29/10/2022.
//

import Foundation
import RxCocoa
import RxSwift
class HistoryViewModel {
    var transactionSubject = BehaviorRelay<[ConverterModel]>(value: [])
    
    
      // method to save data in coreData with some parameters
    
    func saveToCoreData (date : String , amount : Int32 , from : String , to : String , result : Double) {
        
        let transaction = ConverterModel(context: PersistentStorage.shared.context)
        transaction.date = date
        transaction.amount = amount
        transaction.from = from
        transaction.to = to
        transaction.result = result
        PersistentStorage.shared.saveContext()
    }
    
    
    
    // method to retrive Data from CoreData and pass it to transactionSubject 
    func retriveDataFromCoreData () {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(ConverterModel.fetchRequest()) as? [ConverterModel] else {return}
            self.transactionSubject.accept(result)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
