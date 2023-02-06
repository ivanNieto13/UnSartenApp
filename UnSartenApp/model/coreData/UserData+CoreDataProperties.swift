//
//  UserData+CoreDataProperties.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 05/02/23.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var userId: String?

}

extension UserData : Identifiable {

}
