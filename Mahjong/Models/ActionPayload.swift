//
//  ActionPayload.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/7/5.
//

import UIKit

enum Action: Int, Codable {
    case PLACEHOLD //占位，无意义
    case ZHUA   //抓牌
    case DA     //打牌
    case CHI    //吃
    case PENG   //碰
    case GANG   //杠
    case HU     //胡
}

public struct ActionPayload: Hashable, Codable {
    var type: Action = .PLACEHOLD
    var showCard: Card = .MAHJONG_PLACEHOLDER
}
