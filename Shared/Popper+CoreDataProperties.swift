//
//  Popper+CoreDataProperties.swift
//  letsgo (iOS)
//
//  Created by Randy Horman on 2023-12-22.
//
//

import Foundation
import CoreData


extension Popper {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Popper> {
        return NSFetchRequest<Popper>(entityName: "Popper")
    }

    @NSManaged public var stopThePop: Date?
    @NSManaged public var getPopping: Date?
    @NSManaged public var whatThePop: String?
    @NSManaged public var howToPop: Int16

}

extension Popper : Identifiable {

}
