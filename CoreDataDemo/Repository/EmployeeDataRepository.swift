//
//  EmployeeDataRepository.swift
//  CoreDataDemo
//
//  Created by unthinkable-mac-0025 on 07/07/21.
//

import Foundation
import CoreData

protocol EmployeeRepository {

    func create(employee: Employee)
    func getAll() -> [Employee]?
    func get(byIdentifier id: UUID) -> Employee?
    func update(employee: Employee) -> Bool
    func delete(id: UUID) -> Bool
}


class EmployeeDataRepository : EmployeeRepository{
    func create(employee: Employee) {
        
        //create a new entity of CDEmployee type
        let cdEmployee = CDEmployee(context: PersistentStorage.shared.context)
        
        //fill the data of the entity with the data from our model
        cdEmployee.email = employee.email
        cdEmployee.name = employee.name
        cdEmployee.id = employee.id
        cdEmployee.profilePic = employee.profilePicture
        
        //save the context
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Employee]? {
        let result = PersistentStorage.shared.fetchManagedObjects(managedObject: CDEmployee.self)
        
        //convert the result to [Employee] type
        var employees : [Employee] = []
        result?.forEach({ (cdEmployee) in
//            let employee = Employee(name: cdEmployee.name, email: cdEmployee.email, profilePicture: cdEmployee.profilePic, id: cdEmployee.id!)
            employees.append(cdEmployee.convertToEmployee())
        })
        
        return employees
    }
    
    func get(byIdentifier id: UUID) -> Employee? {
        let result = getCDEmployee(byIdentifier: id)
        guard result != nil else { return nil}
        return result?.convertToEmployee()
    }
    
    func update(employee: Employee) -> Bool{
        //get the entities with matching id
        let cdEmployee = getCDEmployee(byIdentifier: employee.id)
        guard cdEmployee != nil else { return false}
        
        //update the details of this fetched entity
        cdEmployee?.email = employee.email
        cdEmployee?.name = employee.name
        cdEmployee?.id = employee.id
        cdEmployee?.profilePic = employee.profilePicture
        
        //save the cahnges
        PersistentStorage.shared.saveContext()
        return true
    } //:update()
    
    func delete(id: UUID) -> Bool{
        //get the entities with matching id
        let cdEmployee = getCDEmployee(byIdentifier: id)
        guard cdEmployee != nil else { return false}
        
        //delted this entity
        PersistentStorage.shared.context.delete(cdEmployee!)
        PersistentStorage.shared.saveContext()
        return true
    } //:delete()
    
    private func getCDEmployee(byIdentifier id : UUID) -> CDEmployee?{
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        do {
            //getting the first element from the result, as get() returns only one eomployee date
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return nil}
            return result
            
        } catch let error {
            print(error)
        }
        return nil
    } //:getCDEmployee()
    
    
}
