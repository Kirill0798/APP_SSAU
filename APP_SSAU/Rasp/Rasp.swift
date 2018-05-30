//
//  Rasp.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 24.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//
struct Rasp: Codable  {
    init() {time = [String](); weeks = [Week]()}
    let time: [String]
    let weeks: [Week]
}

struct Week: Codable {
    let weekNumber: Int
    let days: [Day]
}

struct Day: Codable {
    init() {
        dayOfWeek = Int()
        couple = [Couple]()
    }
    let dayOfWeek: Int
    let couple: [Couple?]
}

struct Couple: Codable {
    let bySubgroups: Bool
    let allGroup, firstSubgroup, secondSubgroup: Lesson?
    
    enum CodingKeys: String, CodingKey {
        case bySubgroups = "by_subgroups"
        case allGroup = "all_group"
        case firstSubgroup = "first_subgroup"
        case secondSubgroup = "second_subgroup"
    }
}

struct Lesson: Codable {
    let number: Int
    let discipline: String
    let type: TypeEnum
    let teacher: Teacher
    let subgroupsInfo: SubgroupsInfo
    
    enum CodingKeys: String, CodingKey {
        case number, discipline, type, teacher
        case subgroupsInfo = "subgroups_info"
    }
}

enum SubgroupsInfo: String, Codable {
    case empty = ""
    case the1Подгр1711152Подгр391317 = "1 подгр. 1,7,11,15 2 подгр. 3,9,13,17 "
    case the1Подгр2610142Подгр481216 = "1 подгр. 2,6,10,14 2 подгр. 4,8,12,16 "
    case the1Подгр3913172Подгр171115 = "1 подгр. 3,9,13,17 2 подгр. 1,7,11,15 "
    case the1Подгр4812162Подгр261014 = "1 подгр. 4,8,12,16 2 подгр. 2,6,10,14 "
}

struct Teacher: Codable {
    let firstName, middleName, lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
    }
}

enum TypeEnum: String, Codable {
    case лабораторныеРаботы = "Лабораторные работы"
    case лекционнаяНагрузка = "Лекционная нагрузка"
    case практическиеЗанятия = "Практические занятия"
}




