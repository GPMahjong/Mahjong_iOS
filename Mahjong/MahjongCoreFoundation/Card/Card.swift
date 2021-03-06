//
//  CardType.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/3.
//

import UIKit

// 麻将牌面对应的数值定义
enum Card: Int, CaseIterable, Codable {
    case MAHJONG_PLACEHOLDER = 0 // 空，占位，无意义
    case MAHJONG_CRAK1            // 万(1 ~ 9)
    case MAHJONG_CRAK2
    case MAHJONG_CRAK3
    case MAHJONG_CRAK4
    case MAHJONG_CRAK5
    case MAHJONG_CRAK6
    case MAHJONG_CRAK7
    case MAHJONG_CRAK8
    case MAHJONG_CRAK9
    case MAHJONG_CRAK_PLACEHOLDER // 10, 占位，无意义
    case MAHJONG_BAM1             // 条(11 ~ 19)
    case MAHJONG_BAM2
    case MAHJONG_BAM3
    case MAHJONG_BAM4
    case MAHJONG_BAM5
    case MAHJONG_BAM6
    case MAHJONG_BAM7
    case MAHJONG_BAM8
    case MAHJONG_BAM9
    case MAHJONG_BAM_PLACE_HOLDER // 20, 占位，无意义
    case MAHJONG_DOT1             // 筒(21 ~ 29)
    case MAHJONG_DOT2
    case MAHJONG_DOT3
    case MAHJONG_DOT4
    case MAHJONG_DOT5
    case MAHJONG_DOT6
    case MAHJONG_DOT7
    case MAHJONG_DOT8
    case MAHJONG_DOT9
    case MAHJONG_DOT_PLACEHOLDER // 30, 占位，无意义

    case MAHJONG_EAST  = 31 // 东南北西 (31 ~ 34)
    case MAHJONG_NORTH = 32
    case MAHJONG_SOUTH = 33
    case MAHJONG_WEST  = 34

    case MAHJONG_GREE  = 41 // 发财、红中、白板 (35 ~ 37)
    case MAHJONG_RED   = 42
    case MAHJONG_WHITE = 43

    case MAHJONG_SEASON1 = 51 // 春夏秋冬（41 ~ 44）
    case MAHJONG_SEASON2 = 52
    case MAHJONG_SEASON3 = 53
    case MAHJONG_SEASON4 = 54

    case MAHJONG_FLOWER1 = 61 // 花色 (45 ~ 48)
    case MAHJONG_FLOWER2 = 62
    case MAHJONG_FLOWER3 = 63
    case MAHJONG_FLOWER4 = 64
}

extension Card: Comparable {
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func <= (lhs: Card, rhs: Card) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    static func > (lhs: Card, rhs: Card) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
    static func >= (lhs: Card, rhs: Card) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    func next() -> Card {
        let nextIndex = rawValue+1
        guard nextIndex < Card.allCases.count else {
            return .MAHJONG_PLACEHOLDER
        }
        return Card.allCases[nextIndex];
    }
    
    func before() -> Card {
        let beforeIndex = rawValue-1
        guard beforeIndex >= 0 else {
            return .MAHJONG_PLACEHOLDER
        }
        return Card.allCases[beforeIndex];
    }
    
}

// SideCards 边张
var SideCards: [Card] = [.MAHJONG_CRAK1, .MAHJONG_CRAK9, .MAHJONG_BAM1, .MAHJONG_BAM9, .MAHJONG_DOT1, .MAHJONG_DOT9]

// LeftSideCards 左边张
var LeftSideCards: [Card] = [.MAHJONG_CRAK1, .MAHJONG_BAM1, .MAHJONG_DOT1]

// RightSideCards 右边张
var RightSideCards: [Card] = [.MAHJONG_CRAK9, .MAHJONG_BAM9, .MAHJONG_DOT9]

// SideNeighborCards 邻边张
var SideNeighborCards: [Card] = [.MAHJONG_CRAK2, .MAHJONG_CRAK8, .MAHJONG_BAM2, .MAHJONG_BAM8, .MAHJONG_DOT2, .MAHJONG_DOT8]

// LeftSideNeighborCards 左邻边张
var LeftSideNeighborCards: [Card] = [.MAHJONG_CRAK2, .MAHJONG_BAM2, .MAHJONG_DOT2]

// RightSideNeighborCards 右邻边张
var RightSideNeighborCards: [Card] = [.MAHJONG_CRAK8, .MAHJONG_BAM8, .MAHJONG_DOT8]

// MahjongCards108 108 张牌
var MahjongCards108: [Card] = [
    // 万
    .MAHJONG_CRAK1, .MAHJONG_CRAK1, .MAHJONG_CRAK1, .MAHJONG_CRAK1,
    .MAHJONG_CRAK2, .MAHJONG_CRAK2, .MAHJONG_CRAK2, .MAHJONG_CRAK2,
    .MAHJONG_CRAK3, .MAHJONG_CRAK3, .MAHJONG_CRAK3, .MAHJONG_CRAK3,
    .MAHJONG_CRAK4, .MAHJONG_CRAK4, .MAHJONG_CRAK4, .MAHJONG_CRAK4,
    .MAHJONG_CRAK5, .MAHJONG_CRAK5, .MAHJONG_CRAK5, .MAHJONG_CRAK5,
    .MAHJONG_CRAK6, .MAHJONG_CRAK6, .MAHJONG_CRAK6, .MAHJONG_CRAK6,
    .MAHJONG_CRAK7, .MAHJONG_CRAK7, .MAHJONG_CRAK7, .MAHJONG_CRAK7,
    .MAHJONG_CRAK8, .MAHJONG_CRAK8, .MAHJONG_CRAK8, .MAHJONG_CRAK8,
    .MAHJONG_CRAK9, .MAHJONG_CRAK9, .MAHJONG_CRAK9, .MAHJONG_CRAK9,

    // 筒
    .MAHJONG_DOT1, .MAHJONG_DOT1, .MAHJONG_DOT1, .MAHJONG_DOT1,
    .MAHJONG_DOT2, .MAHJONG_DOT2, .MAHJONG_DOT2, .MAHJONG_DOT2,
    .MAHJONG_DOT3, .MAHJONG_DOT3, .MAHJONG_DOT3, .MAHJONG_DOT3,
    .MAHJONG_DOT4, .MAHJONG_DOT4, .MAHJONG_DOT4, .MAHJONG_DOT4,
    .MAHJONG_DOT5, .MAHJONG_DOT5, .MAHJONG_DOT5, .MAHJONG_DOT5,
    .MAHJONG_DOT6, .MAHJONG_DOT6, .MAHJONG_DOT6, .MAHJONG_DOT6,
    .MAHJONG_DOT7, .MAHJONG_DOT7, .MAHJONG_DOT7, .MAHJONG_DOT7,
    .MAHJONG_DOT8, .MAHJONG_DOT8, .MAHJONG_DOT8, .MAHJONG_DOT8,
    .MAHJONG_DOT9, .MAHJONG_DOT9, .MAHJONG_DOT9, .MAHJONG_DOT9,

    // 条
    .MAHJONG_BAM1, .MAHJONG_BAM1, .MAHJONG_BAM1, .MAHJONG_BAM1,
    .MAHJONG_BAM2, .MAHJONG_BAM2, .MAHJONG_BAM2, .MAHJONG_BAM2,
    .MAHJONG_BAM3, .MAHJONG_BAM3, .MAHJONG_BAM3, .MAHJONG_BAM3,
    .MAHJONG_BAM4, .MAHJONG_BAM4, .MAHJONG_BAM4, .MAHJONG_BAM4,
    .MAHJONG_BAM5, .MAHJONG_BAM5, .MAHJONG_BAM5, .MAHJONG_BAM5,
    .MAHJONG_BAM6, .MAHJONG_BAM6, .MAHJONG_BAM6, .MAHJONG_BAM6,
    .MAHJONG_BAM7, .MAHJONG_BAM7, .MAHJONG_BAM7, .MAHJONG_BAM7,
    .MAHJONG_BAM8, .MAHJONG_BAM8, .MAHJONG_BAM8, .MAHJONG_BAM8,
    .MAHJONG_BAM9, .MAHJONG_BAM9, .MAHJONG_BAM9, .MAHJONG_BAM9,
]

// MahjongCards72 72 张牌
var MahjongCards72: [Card] = [
    // 筒
    .MAHJONG_DOT1, .MAHJONG_DOT1, .MAHJONG_DOT1, .MAHJONG_DOT1,
    .MAHJONG_DOT2, .MAHJONG_DOT2, .MAHJONG_DOT2, .MAHJONG_DOT2,
    .MAHJONG_DOT3, .MAHJONG_DOT3, .MAHJONG_DOT3, .MAHJONG_DOT3,
    .MAHJONG_DOT4, .MAHJONG_DOT4, .MAHJONG_DOT4, .MAHJONG_DOT4,
    .MAHJONG_DOT5, .MAHJONG_DOT5, .MAHJONG_DOT5, .MAHJONG_DOT5,
    .MAHJONG_DOT6, .MAHJONG_DOT6, .MAHJONG_DOT6, .MAHJONG_DOT6,
    .MAHJONG_DOT7, .MAHJONG_DOT7, .MAHJONG_DOT7, .MAHJONG_DOT7,
    .MAHJONG_DOT8, .MAHJONG_DOT8, .MAHJONG_DOT8, .MAHJONG_DOT8,
    .MAHJONG_DOT9, .MAHJONG_DOT9, .MAHJONG_DOT9, .MAHJONG_DOT9,

    // 条
    .MAHJONG_BAM1, .MAHJONG_BAM1, .MAHJONG_BAM1, .MAHJONG_BAM1,
    .MAHJONG_BAM2, .MAHJONG_BAM2, .MAHJONG_BAM2, .MAHJONG_BAM2,
    .MAHJONG_BAM3, .MAHJONG_BAM3, .MAHJONG_BAM3, .MAHJONG_BAM3,
    .MAHJONG_BAM4, .MAHJONG_BAM4, .MAHJONG_BAM4, .MAHJONG_BAM4,
    .MAHJONG_BAM5, .MAHJONG_BAM5, .MAHJONG_BAM5, .MAHJONG_BAM5,
    .MAHJONG_BAM6, .MAHJONG_BAM6, .MAHJONG_BAM6, .MAHJONG_BAM6,
    .MAHJONG_BAM7, .MAHJONG_BAM7, .MAHJONG_BAM7, .MAHJONG_BAM7,
    .MAHJONG_BAM8, .MAHJONG_BAM8, .MAHJONG_BAM8, .MAHJONG_BAM8,
    .MAHJONG_BAM9, .MAHJONG_BAM9, .MAHJONG_BAM9, .MAHJONG_BAM9,
]

// MahjongCards36 36 张牌
var MahjongCards36: [Card] = [
    // 万
    .MAHJONG_CRAK1, .MAHJONG_CRAK1, .MAHJONG_CRAK1, .MAHJONG_CRAK1,
    .MAHJONG_CRAK2, .MAHJONG_CRAK2, .MAHJONG_CRAK2, .MAHJONG_CRAK2,
    .MAHJONG_CRAK3, .MAHJONG_CRAK3, .MAHJONG_CRAK3, .MAHJONG_CRAK3,
    .MAHJONG_CRAK4, .MAHJONG_CRAK4, .MAHJONG_CRAK4, .MAHJONG_CRAK4,
    .MAHJONG_CRAK5, .MAHJONG_CRAK5, .MAHJONG_CRAK5, .MAHJONG_CRAK5,
    .MAHJONG_CRAK6, .MAHJONG_CRAK6, .MAHJONG_CRAK6, .MAHJONG_CRAK6,
    .MAHJONG_CRAK7, .MAHJONG_CRAK7, .MAHJONG_CRAK7, .MAHJONG_CRAK7,
    .MAHJONG_CRAK8, .MAHJONG_CRAK8, .MAHJONG_CRAK8, .MAHJONG_CRAK8,
    .MAHJONG_CRAK9, .MAHJONG_CRAK9, .MAHJONG_CRAK9, .MAHJONG_CRAK9,
]
