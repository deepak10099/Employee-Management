//
//  Employee.swift
//  Employee Management
//
//  Created by Deepak on 04/02/17.
//  Copyright © 2017 Deepak. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


public class Employee: NSManagedObject {
    @NSManaged public var address: String?
    @NSManaged public var designation: String?
    @NSManaged public var dob: NSDate?
    @NSManaged public var gender: String?
    @NSManaged public var hobbies: String?
    @NSManaged public var name: String?
    @NSManaged public var profilePic: NSData?
}
