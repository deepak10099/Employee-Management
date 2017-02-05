//
//  Employee+CoreDataProperties.swift
//  Employee Management
//
//  Created by Deepak on 05/02/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee");
    }

    @NSManaged public var address: String?
    @NSManaged public var designation: String?
    @NSManaged public var dob: NSDate?
    @NSManaged public var gender: String?
    @NSManaged public var hobbies: String?
    @NSManaged public var name: String?
    @NSManaged public var profilePic: NSData?
    @NSManaged public var dateOfJoining: NSDate?

}
