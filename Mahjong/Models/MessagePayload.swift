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
    case isReady
    case bookMaker
    case dice
    case lack
    case hasAction
    case message
}
public class BasicMessage: Codable {
    var uuid: String = User.localUser().uuid
}

public class MessagePayload: BasicMessage {
    var type: MessageType = .NONE
    var isHomeowener: Bool = false
    var boolmaker: User = User.localUser()
    var isReady: Bool = false
    var hasAction: Bool = false
    var diceNumber: Int = 0
    var participants: [User] = []
}

public class MahjongPayload: BasicMessage {
    var tiles: [Card] = []
    var handTiles: [Card] = []
}

extension MessagePayload {
    static func createRoomMessage() -> MessagePayload {
        let message = MessagePayload()
        message.type = .createRoom
        message.isHomeowener = true
        return message
    }
    
    static func isReadyMessage() -> MessagePayload {
        let message = MessagePayload()
        message.type = .isReady
        message.isReady = true
        return message
    }
    
    static func bookMakerMessage(_ boolmaker: User) -> MessagePayload {
        let message = MessagePayload()
        message.type = .bookMaker
        message.boolmaker = boolmaker
        return message
    }
}
