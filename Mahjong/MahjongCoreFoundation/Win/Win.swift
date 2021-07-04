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
    func canWin(handCards: [Card], showCards: [Card]) -> Bool {
        var sortedCards = handCards.sorted { $0.rawValue > $1.rawValue }
        // 找到所有的对
        var pos = findPairPos(sortedCards)
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
        var lastPairTile: Card // 上次做为对的牌
        for posIndex in pos {
            // 避免有4张同样手牌时，多判断一次
            if sortedCards[posIndex] == lastPairTile {
                continue
            } else {
                lastPairTile = sortedCards[posIndex]
            }
            let cards = removePair(sortedCards, posIndex)
            if isAllSequenceOrTriplet(cards) {
                return true
            }
        }
        for _, v := range pos {
            // 避免有4张同样手牌时，多判断一次
            if sortedCards[v] == lastPairTile {
                continue
            } else {
                lastPairTile = sortedCards[v]
            }
            cards := RemovePair(sortedCards, v)
            if IsAllSequenceOrTriplet(cards) {
                return true
            }
        }
        return false
    }

    // FindPairPos 找出所有对牌的位置
    // 传入的牌需要是已排序的
    func findPairPos(_ sortedCards: [Card]) -> [Int] {
        var pos: [Int]
        sortedCards.enumerated().forEach { (index, card) in
            if card == sortedCards[index + 1] {
                pos.append(index)
            }
        }
        return pos
    }

    // RemovePair 从已排序的牌中，移除一对
    func removePair(_ sortedCards: [Card], _ pos: Int) -> [Card] {
        var remainCards: [Card] = sortedCards
        remainCards.removeSubrange(pos..<pos+2)
        return remainCards
    }

    // IsAllSequenceOrTriplet 是否全部顺或者刻
    // 传入的牌需要是已排序的
    func isAllSequenceOrTriplet(_ sortedCards: [Card]) -> Bool {
        
        
//        cardsLen := len(sortedCards)
//        for i := 0; i < cardsLen/3; i++ {
//            find := FindAndRemoveTriplet(&sortedCards)
//            if !find {
//                find = FindAndRemoveSequence(&sortedCards)
//            }
//            if !find {
//                return false
//            }
//        }
//        return len(sortedCards) == 0
        return true
    }

    // FindAndRemoveTriplet 从已排序的[]int中移除排头的刻子
    func findAndRemoveTriplet(_ sortedCards: inout [Card]) -> Bool {
        if isTriplet(sortedCards[0], sortedCards[1], sortedCards[2]) {
            sortedCards.removeSubrange(0...2)
            return true
        }
        return false
    }

    // FindAndRemoveSequence 从已排序的[]int中移除排头的顺子
    func FindAndRemoveSequence(_ sortedCards: inout [Card]) -> Bool {
        var v = sortedCards
        var tmp: [Card] = []
        for i := 1; i < len(v); i++ {
            switch {
            case v[i] == v[i-1]:
                tmp = append(tmp, v[i])
            case v[i] == v[i-1]+1:
                if v[i]-v[0] == 2 {
                    tmp = append(tmp, v[i+1:]...)
                    *sortedCards = tmp
                    return true
                }
            default:
                return false
            }
        }
        return false
    }

    // IsSequence 是否顺子
    // 传入的牌必须是已排序的
    // 非万、筒、条肯定不是顺
    func isSequence(tileA: Card, tileB: Card, tileC: Card) -> Bool {
        if !Card.IsSuit(tileA) || !Card.IsSuit(tileB) || !Card.IsSuit(tileC) {
            return false
        }
        if tileB.rawValue == tileA.rawValue+1 && tileC.rawValue == tileB.rawValue+1 {
            return true
        }
        return false
    }

    // IsTriplet 是否刻子
    func isTriplet(tileA: Card, tileB: Card, tileC: Card) -> Bool {
        if tileB == tileA && tileC == tileB {
            return true
        }
        return false
    }

    // FindSequenceOrTripletCnt 找出当前牌中所有刻和顺的数量
    // 返回数量和抽完剩余的牌
    func findSequenceOrTripletCnt(sortedCards: [Card]) -> (Int, [Card]) {
        var cnt = 0
        var remain: [Card] = []
        var sortedCardsCopy = sortedCards
        while sortedCardsCopy.count > 2 {
            let find = findAndRemoveTriplet(&sortedCards)
            if !find {
                find = FindAndRemoveSequence(&sortedCards)
            }
            if find {
                cnt++
            } else {
                remain = append(remain, sortedCards[0])
                sortedCards = sortedCards[1:]
            }
        }
        remain.append(contentsOf: sortedCardsCopy)
        
        for {
            if sortedCards.count <= 2 {
                remain.append(contentsOf: sortedCards)
                break
            }
            let find = findAndRemoveTriplet(&sortedCards)
            if !find {
                find = FindAndRemoveSequence(&sortedCards)
            }
            if find {
                cnt++
            } else {
                remain = append(remain, sortedCards[0])
                sortedCards = sortedCards[1:]
            }
        }
        return cnt, remain
    }
}
