//
//  CDEmployee+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by unthinkable-mac-0025 on 24/06/22.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var profilePic: Data?
    @NSManaged public var toPassport: CDPassport?
    
    //custom functions
    func convertToEmployee() ->Employee{
        return Employee(name: self.name, email: self.email, profilePicture: self.profilePic, id: self.id!)
    }
}

extension CDEmployee : Identifiable {

}
