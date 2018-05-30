//
//  Budet+CoreDataProperties.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 22.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//
//

import Foundation
import CoreData


extension Budet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budet> {
        return NSFetchRequest<Budet>(entityName: "Budet")
    }

    @NSManaged public var icho: NSObject?

}
