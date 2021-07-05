//
//  Ting.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/3.
//

import UIKit

class Ting: NSObject {
    // CanTing 判断牌型是否可以听牌
    // 返回是否可听、听什么
    static func CanTing(handCards: [Card], showCards: [Card]) -> (Bool, [Card]) {
        var canTing = false
        var tingCards: [Card] = []
        // 循环将可能听的牌，带入到手牌，再用胡牌算法检测是否可胡
        for card in GetMaybeTing(handCards: handCards, showCards: showCards) {
            if Win.canWin(handCards, showCards) {
                canTing = true
                tingCards.append(card)
            }
        }
        return (canTing, tingCards)
    }

    // GetMaybeTing 获取哪些牌是可能听的
    // 东南西北、花色等，只有自身
    // 边张只有自身或者上下张的某一张
    // 其他的是自身和上下张
    // 如果有明牌，且明牌是3张的话，则明牌也可能是胡的
    static func GetMaybeTing(handCards: [Card], showCards: [Card]) -> [Card] {
        var maybeCards: [Card] = Card.GetSelfAndNeighborCards(cards: handCards)
        if showCards.count == 3 &&
            showCards[0] == showCards[1] && showCards[1] == showCards[2] &&
            !maybeCards.contains(showCards[0]) {
            maybeCards.append(showCards[0])
        }
        return maybeCards
    }

    // GetTingMap 获取可听的列表
    // key: 打什么
    // value: 听哪些
    static func GetTingMap(handCards: [Card], showCards: [Card]) -> [Card : [Card]] {
        var tingMap :[Card : [Card]] = [:]
        let handCardsLength = handCards.count
        handCards.enumerated().forEach { (index, playCard) in
            var handCardsTmp: [Card] = []
            handCardsTmp.append(contentsOf: Array(handCards[0..<index]))
            handCardsTmp.append(contentsOf: Array(handCards[index..<handCardsLength]))
            let tingCards = CanTing(handCards: handCardsTmp, showCards: showCards)
            tingMap[playCard] = tingCards.1
        }
        return tingMap
    }
}
