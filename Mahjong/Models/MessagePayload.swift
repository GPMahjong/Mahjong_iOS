//
//  MessagePayload.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import Foundation

enum MessageType: Int, Codable {
    case NONE //占位，无意义
    case createRoom
    case uuid
    case participants
    case isReady
    case bookMaker
    case dice
    case lack
    case hasAction
    case message
}
public class BasicMessage: Codable {
    var uuid: String = ""
    var type: MessageType = .NONE
}

public class MessagePayload: BasicMessage {
    var isHomeowener: Bool = false
    var isBoolmaker: Bool = false
    var isReady: Bool = false
    var hasAction: Bool = false
    var diceNumber: Int = 0
    let participants: [User] = []
}
