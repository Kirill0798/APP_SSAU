//
//  Student.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 25.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import Foundation
struct Student: Codable {
    init(){
        id = Int()
        login = String()
        password = String()
        token = String()
        firstName = String()
        middleName = String()
        lastName = String()
        birthday = String()
        gender = String()
        phoneNumber = String()
        group = myGroup()
        groupPresident = Int()
        groupManager = Int()
        groupProforg = Int()
    }
    let id: Int
    let login, password, token, firstName: String
    let middleName, lastName, birthday, gender: String
    let phoneNumber: String
    let group: myGroup
    let groupPresident, groupProforg, groupManager: Int
    
    enum CodingKeys: String, CodingKey {
        case id, login, password, token
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case birthday, gender
        case phoneNumber = "phone_number"
        case group
        case groupPresident = "group_president"
        case groupProforg = "group_proforg"
        case groupManager = "group_manager"
    }
}

struct myGroup: Codable {
    init(){
        number = String()
    }
    let number: String
}
