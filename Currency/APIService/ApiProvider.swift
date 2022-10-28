//
//  ApiProvider.swift
//  Currency
//
//  Created by MacBook on 28/10/2022.
//

import Foundation
import Moya



enum DataService {
    case getSymbols
    case converter(Int,String,String)
}
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case.getSymbols :
            return.get
        case.converter :
            return.get
        }
    }
    
    var task: Task {
        switch self {
        case.getSymbols :
            return .requestPlain
        case.converter(let amount , let from , let to ):
            
            return.requestParameters(parameters: ["to":(to),"from":(from),"amount":(amount)], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        ["apikey":"C58KNZw5WCJjBlBcEDVHxWY6F7WmOqJ1"]
    }
    
    var authorizationType: AuthorizationType? {
        return.bearer
    }
    
    
    
}
