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
class ApiService {
    
    static let shared = ApiService()
    let provider = MoyaProvider<DataService>(
        plugins : [
            AccessTokenPlugin { _ in
                return ""

            },
            NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions : .verbose) )
        ]
    )

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
    
    func conver(compoletion : @escaping (Result<Converter,Error> ) -> Void) {
        provider.request(.converter(1, "USD", "EGP")) { result in
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
    
    
    
}
