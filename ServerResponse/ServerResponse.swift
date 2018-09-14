//
//  ServerResponse.swift
//  APP_SSAU
//
//  Created by Pavel Belyaev(пушок) on 25.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import Foundation

struct ServerResponse: Codable {
    init(){
        response = "unknown"
    }
    let response :String?
}
