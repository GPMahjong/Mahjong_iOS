//
//  Win.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/3.
//

import UIKit

class Win {

    // CanWin 判断当前牌型是否是胡牌牌型(7对或4A+2B)
    // 需要根据手牌和明牌去判断是否胡牌
    static func canWin(_ handCards: [Card], _ showCards: [Card]) -> Bool {
        let sortedCards = handCards.sorted { $0.rawValue < $1.rawValue }
        // 找到所有的对
        let pos = findPairPos(sortedCards)
        // 找不到对，无法胡牌
        if pos.isEmpty {
            return false
        }

        // 7对(目前版本只有手中为7个对才可以胡)
        if pos.count == 7 {
            return true
        }

        // 地龙
        // 手牌有5对;明牌3张;明牌三张相同;且手牌的孤张与明牌相同
        if pos.count == 5 &&
            showCards.count == 3 &&
            showCards[0] == showCards[1] && showCards[0] == showCards[2] &&
            handCards.contains(showCards[0]) {
            return true
        }

        // 遍历所有对，因为胡必须有对
        var lastPairTile: Card = .MAHJONG_PLACEHOLDER// 上次做为对的牌
        for posIndex in pos {
            // 避免有4张同样手牌时，多判断一次
            if sortedCards[posIndex] == lastPairTile {
                continue
            } else {
                lastPairTile = sortedCards[posIndex]
            }
            var cards = removePair(sortedCards, posIndex)
            if isAllSequenceOrTriplet(&cards) {
                return true
            }
        }
        return false
    }

    // FindPairPos 找出所有对牌的位置
    // 传入的牌需要是已排序的
    static func findPairPos(_ sortedCards: [Card]) -> [Int] {
        var pos: [Int] = []
        var gangRange: Range<Int>?
        sortedCards.enumerated().forEach { (index, card) in
            //特殊处理四个一样的牌
            if sortedCards.count >= 4, index <= sortedCards.count - 4, card == sortedCards[index+1],card == sortedCards[index+2],card == sortedCards[index+3] {
                gangRange = (index..<index+4)
                pos.append(index)
                pos.append(index+2)
            } else if index < sortedCards.count - 1 ,card == sortedCards[index + 1] {
                if let rang = gangRange, rang.contains(index) {
                    //四个连续牌已经处理过了，这里不需要重复处理
                } else {
                    pos.append(index)
                }
            }
        }
        return pos
    }

    // RemovePair 从已排序的牌中，移除一对
    static func removePair(_ sortedCards: [Card], _ pos: Int) -> [Card] {
        var remainCards: [Card] = sortedCards
        remainCards.removeSubrange(pos..<pos+2)
        return remainCards
    }

    // IsAllSequenceOrTriplet 是否全部顺或者刻
    // 传入的牌需要是已排序的
    static func isAllSequenceOrTriplet(_ sortedCards: inout [Card]) -> Bool {
        let cardsLen = sortedCards.count
        var i = 0
        while i < cardsLen / 3 {
            i += 1
            var find = findAndRemoveTriplet(&sortedCards)
            if !find {
                find = findAndRemoveSequence(&sortedCards)
            }
            if !find {
                return false
            }
        }
        return sortedCards.isEmpty
    }

    // FindAndRemoveTriplet 从已排序的[]int中移除排头的刻子
    static func findAndRemoveTriplet(_ sortedCards: inout [Card]) -> Bool {
        if isTriplet(sortedCards[0], sortedCards[1], sortedCards[2]) {
            sortedCards.removeSubrange(0...2)
            return true
        }
        return false
    }

    // FindAndRemoveSequence 从已排序的[]int中移除所有的顺子
    static func findAndRemoveSequence(_ sortedCards: inout [Card]) -> Bool {
        guard sortedCards.count >= 3 else { return false }
        var tmp: [Card] = []
        let v = sortedCards
        var hasPreSequence: Bool = false
        if v[1].rawValue == v[0].rawValue + 1, v[1].rawValue == v[2].rawValue - 1 {
            sortedCards.removeSubrange(0...2)
            hasPreSequence = true
        } else {
            tmp.append(v[0])
            sortedCards.removeFirst()
        }
        hasPreSequence = hasPreSequence || findAndRemoveSequence(&sortedCards)
        sortedCards.append(contentsOf: tmp)
        return hasPreSequence
    }

    // IsSequence 是否顺子
    // 传入的牌必须是已排序的
    // 非万、筒、条肯定不是顺
    static func isSequence(tileA: Card, tileB: Card, tileC: Card) -> Bool {
        if !tileA.isSuit() || !tileB.isSuit() || !tileC.isSuit() {
            return false
        }
        if tileB.rawValue == tileA.rawValue+1 && tileC.rawValue == tileB.rawValue+1 {
            return true
        }
        return false
    }

    // IsTriplet 是否刻子
    static func isTriplet(_ tileA: Card, _ tileB: Card, _ tileC: Card) -> Bool {
        if tileB == tileA && tileC == tileB {
            return true
        }
        return false
    }

    // FindSequenceOrTripletCnt 找出当前牌中所有刻和顺的数量
    // 返回数量和抽完剩余的牌
    static func findSequenceOrTripletCnt(sortedCards: [Card]) -> (Int, [Card]) {
        var cnt = 0
        var remain: [Card] = []
        var sortedCardsCopy = sortedCards
        while sortedCardsCopy.count > 2 {
            var find: Bool = findAndRemoveTriplet(&sortedCardsCopy)
            if !find {
                find = findAndRemoveSequence(&sortedCardsCopy)
            }
            if find {
                cnt += 1
            } else {
                remain.append(sortedCardsCopy[0])
                sortedCardsCopy.removeFirst()
            }
        }
        remain.append(contentsOf: sortedCardsCopy)
        
        return (cnt, remain)
    }
}
