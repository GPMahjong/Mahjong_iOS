//
//  MessagePayload.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import Foundation

public class BasicMessage: Codable {
    var uuid: String = ""
}

public class MessagePayload: BasicMessage {
    var isHomeowener: Bool = false
    var isBoolmaker: Bool = false
    var isReady: Bool = false
    var hasAction: Bool = false
    var diceNumber: Int = 0
    let participants: [User] = []
    
}
