//
//  CoreDataHandler.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 25.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    class func saveHandleObject(login:String, password: String, gender:String,birthday:String, groupManager:Int32, groupProforg:Int32,groupPresident:Int32, token:String, firstName: String, middleName:String, lastName: String, phoneNumber: String, studyGroup: String) -> Bool{
        let handleContext = getContext()
        let handleEntity = NSEntityDescription.entity(forEntityName: "User", in: handleContext)
        let manageObject = NSManagedObject(entity: handleEntity!, insertInto: handleContext)
        manageObject.setValue(login, forKey:"login")
        manageObject.setValue(password, forKey:"password")
        manageObject.setValue(gender, forKey:"gender")
        manageObject.setValue(token, forKey: "token")
        manageObject.setValue(firstName, forKey: "firstName")
        manageObject.setValue(middleName, forKey: "middleName")
        manageObject.setValue(lastName, forKey: "lastName")
        manageObject.setValue(groupManager, forKey:"groupManager")
        manageObject.setValue(groupProforg, forKey:"groupProforg")
        manageObject.setValue(groupPresident, forKey:"groupPresident")
        manageObject.setValue(studyGroup, forKey: "studyGroup")
        manageObject.setValue(gender, forKey: "gender")
        manageObject.setValue(phoneNumber, forKey: "phoneNumber")
        manageObject.setValue(birthday, forKey: "birthday")
        do {
            try handleContext.save()
            return true
        }catch {
            return false
        }
    }
    class func fetchObject() -> [User]? {
        let context = getContext()
        var user:[User]? = nil
        do {
            user = try context.fetch(User.fetchRequest())
            return user
        }catch {
            return user
        }
    }
}
