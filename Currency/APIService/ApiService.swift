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
    
    
    
    func getSymbols(completion : @escaping (Result <[String:String] , Error>)-> Void) {
        var request = URLRequest(url: URL(string: EndPoints.symbols.rawValue)!)
        request.httpMethod = "GET"
        request.addValue("3wy3tlRKIjiPmzwWZ5SHjufdGkEvjFJv", forHTTPHeaderField: "apikey")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse else {
                
                return
            }
//            print(response.statusCode)
            switch response.statusCode {
            case 400 :
                print("")
            default :
                print("")
            }
            guard let data = data else{
                print("empty Data")
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(Symbols.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData.symbols))
                }
                
                
            }
            catch let error {
                completion(.failure(error))
            }
            
            
        }.resume()
    }
    let provider = MoyaProvider<DataService>()
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
    
    func conver() {
        
    }
    
    
    
}
