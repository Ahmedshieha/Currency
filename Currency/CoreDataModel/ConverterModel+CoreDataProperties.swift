//
//  ConverterModel+CoreDataProperties.swift
//  Currency
//
//  Created by MacBook on 29/10/2022.
//
//

import Foundation
import CoreData


extension ConverterModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConverterModel> {
        return NSFetchRequest<ConverterModel>(entityName: "ConverterModel")
    }

    @NSManaged public var date: String?
    @NSManaged public var from: String?
    @NSManaged public var to: String?
    @NSManaged public var amount: Int32
    @NSManaged public var result: Double

}

extension ConverterModel : Identifiable {

}
