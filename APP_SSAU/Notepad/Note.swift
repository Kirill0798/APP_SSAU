//
//  Note.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 24.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import Foundation
struct Note: Codable {
    init(){response = [Response]()}
    let response: [Response]
}

struct Response: Codable {
    let group: Group
    let lesson, text: String
}

struct Group: Codable {
    let number: String
}
