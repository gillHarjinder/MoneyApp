//
//  MoneyValue+CoreDataProperties.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 5/16/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import Foundation
import CoreData


extension MoneyValue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoneyValue> {
        return NSFetchRequest<MoneyValue>(entityName: "MoneyValue")
    }

    @NSManaged public var category: String?
    @NSManaged public var type: Bool
    @NSManaged public var reacuring: Bool
    @NSManaged public var date: String?
    @NSManaged public var name: String?
    @NSManaged public var amount: Double

}
