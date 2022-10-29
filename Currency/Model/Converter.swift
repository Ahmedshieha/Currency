//
//  Converter.swift
//  Currency
//
//  Created by MacBook on 28/10/2022.
//

import Foundation
import CoreData


struct Converter: Codable {
    let date: String
    let info: Info
    let query: Query
    let result: Double
    let success: Bool
}

// MARK: - Info
struct Info: Codable {
    let rate: Double
    let timestamp: Int
}

// MARK: - Query
struct Query: Codable {
    let amount: Int
    let from, to: String
}


protocol StructDecoder {
    static var EntityName : String {get}
    func toCoreData(context : NSManagedObjectContext) throws -> NSManagedObject
}

enum SerializationError : Error {
 
    
    case structRequired
    case unKnownEntity (name :String)
    case unsupportedSubType (lable : String)
}

//extension StructDecoder {
//    func toCoreData(context: NSManagedObjectContext) throws -> NSManagedObject {
//        let entityName = type(of: self).EntityName
//        guard let desc = NSEntityDescription.entity(forEntityName: entityName, in: context) else { SerializationError.unKnownEntity(name: entityName) }
//        let managedObject = NSManagedObject(entity: desc, insertInto: context)
//
//        let mirror = Mirror(reflecting: self)
//
//        guard mirror.displayStyle == .struct else {throw  SerializationError.structRequired}
//
//        for case let (lable? , anyValue) in mirror.children {
//            managedObject.setValue(anyVaue, forKey: lable)
//        }
//        return managedObject
//
//         }
//}
