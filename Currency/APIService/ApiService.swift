//
//  ApiService.swift
//  Currency
//
//  Created by MacBook on 28/10/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya


 // class for handle api methods
class ApiService {
    
    static let shared = ApiService()
    
    // moya provider to take AccessToken if availaple and print logger to test your data and request
    
    let provider = MoyaProvider<DataService>(
        plugins : [
            AccessTokenPlugin { _ in
                return ""

            },
            NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions : .verbose) )
        ]
    )
    
    
    // method to get available currencies

    func getSymbolsWithMoya(completion : @escaping (Result <[String:String] , Error>)-> Void) {
        provider.request(.getSymbols) { result in
            switch result {
            case.success(let response) :
                do {
                    let jsonData = try JSONDecoder().decode(Symbols.self, from: response.data)
                    completion(.success(jsonData.symbols))
                    
                }
                catch let error {
                    print(error.localizedDescription)
                }
            case.failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
      // method to convert from currency to another with parameters amount & from and to
    
    func convertCurrency(amount : Int , from : String , to : String ,compoletion : @escaping (Result<Converter,Error> ) -> Void) {
        provider.request(.converter(amount, from , to)) { result in
            switch result {
            case.success(let response):
                do {
                    
                    let jsonData = try JSONDecoder().decode(Converter.self, from: response.data)
                    compoletion(.success(jsonData))
                    print(jsonData.result)
                }
                catch let error {
                    print("\(error.localizedDescription) error in Decoder")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // method to get top 10 popular currencies from base currency that you convert
    
    func otherCurrencies(base : String , symbols : String , completion : @escaping (Result<OtherCurrencies,Error>) -> Void) {
        provider.request(.otherCurrencies(base, symbols)) { result in
            switch result {
            case.success(let response):
                do {
                    
                    let jsonData = try JSONDecoder().decode(OtherCurrencies.self, from: response.data)
                    completion(.success(jsonData))
            
                }
                catch let error {
                    print("\(error.localizedDescription) error in Decoder")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
