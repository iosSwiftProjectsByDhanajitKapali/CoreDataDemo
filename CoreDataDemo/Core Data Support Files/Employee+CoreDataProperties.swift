//
//  Employee+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by unthinkable-mac-0025 on 06/07/21.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var email : String?
    @NSManaged public var id : UUID?
    @NSManaged public var profilePic : Data?
    

}

extension Employee : Identifiable {

}
