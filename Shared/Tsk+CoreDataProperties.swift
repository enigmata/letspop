//
//  Tsk+CoreDataProperties.swift
//  letsgo (iOS)
//
//  Created by Randy Horman on 2023-12-21.
//
//

import Foundation
import CoreData


extension Tsk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tsk> {
        return NSFetchRequest<Tsk>(entityName: "Tsk")
    }

    @NSManaged public var endTime: Date?
    @NSManaged public var startTime: Date?
    @NSManaged public var title: String?
    @NSManaged public var type: Int16

}

extension Tsk : Identifiable {

}
