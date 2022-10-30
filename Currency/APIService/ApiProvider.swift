//
//  ApiProvider.swift
//  Currency
//
//  Created by MacBook on 28/10/2022.
//

import Foundation
import Moya


 // enum for endPoints that i use

enum DataService {
    case getSymbols
    case converter(Int,String,String)
    case otherCurrencies(String,String)
    
}

// extension for enum of targrtType which make it easy to handle url , methods , task and path of url 
extension DataService :TargetType , AccessTokenAuthorizable {
    
    var baseURL: URL {
        URL(string: "https://api.apilayer.com/fixer")!
    }
    
    var path: String {
        switch self {
        case.getSymbols :
            return "symbols"
        case.converter :
            return "convert"
        case.otherCurrencies:
            return "latest"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case.getSymbols :
            return.get
        case.converter :
            return.get
        case.otherCurrencies:
            return.get
        }
    }
    
    var task: Task {
        switch self {
        case.getSymbols :
            return .requestPlain
        case.converter(let amount , let from , let to ):
            
            return.requestParameters(parameters: ["to":(to),"from":(from),"amount":(amount)], encoding: URLEncoding.queryString)
        case.otherCurrencies(let base , let symbols):
            return.requestParameters(parameters: ["base":(base) , "symbols":(symbols)], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        ["apikey":"M0gp80UaXYtW8LwpwixH2U7CaLds1axS"]
    }
    
    var authorizationType: AuthorizationType? {
        return.bearer
    }
    
    
    
}
