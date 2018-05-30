//
//  User+CoreDataProperties.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 22.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var login: String?
    @NSManaged public var password: String?

}
