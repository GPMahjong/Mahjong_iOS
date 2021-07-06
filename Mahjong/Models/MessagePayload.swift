//
//  MessagePayload.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import Foundation

protocol BasicMessage: Hashable, Codable {
    var uuid: String { get set }
}

public struct MessagePayload: BasicMessage {
    var uuid: String = ""
    var isHomeowener: Bool = false
    var isBoolmaker: Bool = false
    var isReady: Bool = false
    var hasAction: Bool = false
    var diceNumber: Int = 0
//    let participants: [User] = []
    
}
