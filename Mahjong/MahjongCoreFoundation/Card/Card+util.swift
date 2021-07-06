//
//  Card.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/3.
//

import UIKit

extension Card {
    // GetSelfAndNeighborCards 获取自身或者相邻的一张牌, 结果需去重
    // 不包括隔张
    // 1条、1筒、1万只有自己和上一张
    // 九条、九筒、九万只有自己和下一张
    // 非万、筒、条 只有自己
    static func GetSelfAndNeighborCards(cards: [Card]) -> [Card] {
        var result: [Card] = []
        for card in cards {
            result.append(card)
            // 非普通牌、只有自身
            if !card.isSuit() {
                continue
            }
            if LeftSideCards.contains(card) {
                result.append(card.next())
            } else if RightSideCards.contains(card) {
                result.append(card.before())
            } else {
                result.append(contentsOf: [card.before(),card.next()])
            }
        }
        return result.unique
    }

    // GetRelationTiles 获取有关联的牌
    // 包括自己、相邻的、跳张
    static func GetRelationTiles(cards: [Card]) -> [Card] {
        var result: [Card] = []
        for card in cards {
            result.append(card)
            // 非普通牌、只有自身
            if !card.isSuit() {
                continue
            }

            if LeftSideCards.contains(card) {
                result.append(contentsOf: [card.next(),card.next().next()])
            } else if LeftSideNeighborCards.contains(card) {
                result.append(contentsOf: [card.next(),card.next().next(),card.before()])
            } else if RightSideNeighborCards.contains(card) {
                result.append(contentsOf: [card.before(),card.before().before(),card.next()])
            } else if RightSideCards.contains(card) {
                result.append(contentsOf: [card.before(),card.before().before()])
            } else {
                result.append(contentsOf: [card.before(),card.before().before(),card.next(),card.next().next()])
            }
        }
        return result
    }

    // IsSameType 检查两张牌是否同类
    static func IsSameType(_ checkCard: Card, _ lackCard: Card) -> Bool {
        return checkCard.rawValue / 10 == lackCard.rawValue / 10
    }
    
    static func CardByValue(value: Int) -> Card {
        guard value < allCases.count else {
            return .MAHJONG_PLACEHOLDER
        }
        return Card.allCases[value]
    }
    
    // IsSuit 是否普通牌
    // 普通牌是指万、筒、条
    func isSuit() -> Bool {
        return self < .MAHJONG_DOT_PLACEHOLDER
    }

    // IsCrak 是否万
    func isCrak() -> Bool {
        return self >= .MAHJONG_CRAK1 && self <= .MAHJONG_CRAK9
    }

    // IsBAM 是否条
    func isBAM() -> Bool {
        return self >= .MAHJONG_BAM1 && self <= .MAHJONG_BAM9
    }

    // IsDot 是否筒
    func isDot() -> Bool {
        return self >= .MAHJONG_DOT1 && self <= .MAHJONG_DOT9
    }

    // GetBehindCardCycle 获取某张牌的下一张牌（循环获取）
    func getBehindCardCycle() -> Card {
        var behind: Int = 0
        if isSuit() {
            if RightSideCards.contains(self) {
                behind = self.rawValue - 8
            } else {
                behind = self.rawValue + 1
            }
        }
        return Card.CardByValue(value: behind)
    }

    // GetFrontCardCycle 获取某张牌的前一张牌（循环获取）
    func getFrontCardCycle() -> Card {
        var front: Int = 0
        if isSuit() {
            if LeftSideCards.contains(self) {
                front = rawValue + 8
            } else {
                front = rawValue - 1
            }
        }
        return Card.CardByValue(value: front)
    }
}
