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
    
    
    let conversionsRelay = BehaviorRelay<[ConverterModel]>(value: [])
    
    func currenciesObservabale ()-> Observable<[SectionOfCustomData]> {
        
        return conversionsRelay.map { list in
            
            let dayTransactionDictionary = Dictionary(grouping: list) { (item) -> String in
                return item.date ?? ""
            }
            
            return dayTransactionDictionary.map {(key , value) in
              return  SectionOfCustomData(header: key, items: value)
            }.filter { sections in
                 
                let interval = Date() - self.getDateAsDate(date: sections.header)
                return interval.day! < 4
            }
        }
    }
    
    func getDateAsDate (date : String)-> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateAsDate = formatter.date(from: date)
        return dateAsDate!
        
    }
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
            self.conversionsRelay.accept(result)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

