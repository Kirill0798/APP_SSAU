//
//  Message.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 25.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import Foundation
struct Message: Codable {
    init(){
        response = [MyResponse]()
    }
    let response: [MyResponse]
}

struct MyResponse: Codable {
    let messageID, senderID, readState: Int
    let senderName: String
    let out: Int
    let body: String
    let time: Int
    
    enum CodingKeys: String, CodingKey {
        case messageID = "message_id"
        case senderID = "sender_id"
        case readState = "read_state"
        case senderName = "sender_name"
        case out, body, time
    }
}
