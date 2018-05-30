//
//  Constants.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 13.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import Foundation

var todoList:[String]?

func saveData(todoList:[String]) {
    UserDefaults.standard.set(todoList, forKey: "todoList")
}
func fetchData() -> [String]?{
    if let todo = UserDefaults.standard.array(forKey: "todoList") as? [String]{
        return todo
    }
    else{
        return nil
    }
}
