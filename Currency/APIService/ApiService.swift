//
//  ApiService.swift
//  Currency
//
//  Created by MacBook on 28/10/2022.
//

import Foundation


class ApiService {
    static let shared = ApiService()
    
    
    
    func getSymbols(completion : @escaping ()-> Void) {
        guard let url = URL(string: EndPoints.symbols.rawValue) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                
            }
        }
    }
    
    
}
