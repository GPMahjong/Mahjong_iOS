//
//  MahjongSeletor.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/7/7.
//

import UIKit

// MSelector 麻将选牌器
class MahjongSeletor {
    
    var aiLevel: Int = 0                   // AI等级
    var tiles: [Card:Int] = [:]            // 所有牌
    var handTiles: [Card:Int] = [:]        // 手牌
    var discardTiles: [Card:Int] = [:]     // 弃牌
    var showTiles: [Card:Int] = [:]        // 明牌
    var remainTiles: [Card:Int] = [:]      // 剩余牌
    var lack: Card = .MAHJONG_PLACEHOLDER  // 缺牌

    // Clean 清空选牌器
    func clean() {
        handTiles = [:]
        discardTiles = [:]
        showTiles = [:]
        remainTiles = [:]
        lack = .MAHJONG_PLACEHOLDER
    }

    // SetTiles 设置所有的牌
    func setTiles(s: [Card]) {
        addArray(s: s, to: &tiles)
    }

    // AddHandTilesMap 添加手牌
    func addHandTilesMap(m :[Card: Int]) {
        mergeMap(m: m, to: &handTiles)
    }

    // AddHandTilesSlice 添加手牌
    func addHandTilesSlice(s: [Card]) {
        addArray(s: s, to: &handTiles)
    }

    // SetHandTilesSlice 设置手牌
    func setHandTilesSlice(s: [Card]) {
        addArray(s: s, to: &handTiles)
    }

    // SetHandTilesMap 设置手牌
    func setHandTilesMap(m: [Card: Int]) {
        handTiles = m
    }

    // ShowHandTiles 显示手牌
    func showHandTiles() -> [Card] {
        return arrayFrom(m: handTiles)
    }

    // AddShowTilesSlice 添加明牌
    func sddShowTilesSlice(s: [Card]) {
        addArray(s: s, to: &showTiles)
    }

    // AddShowTilesMap 添加明牌
    func addShowTilesMap(m: [Card: Int]) {
        mergeMap(m: m, to: &showTiles)
    }

    // SetShowTilesSlice 添加明牌
    func setShowTilesSlice(s: [Card]) {
        addArray(s: s, to: &showTiles)
    }

    // SetShowTilesMap 添加明牌
    func setShowTilesMap(m: [Card: Int]) {
        showTiles = m
    }

    // ShowShowTiles 显示明牌
    func showShowTiles() -> [Card] {
        return arrayFrom(m: showTiles)
    }

    // AddDiscardTilesSlice 添加弃牌
    func addDiscardTilesSlice(s: [Card]) {
        addArray(s: s, to: &discardTiles)
    }

    // AddDiscardTilesMap 添加弃牌
    func addDiscardTilesMap(m: [Card: Int]) {
        mergeMap(m: m, to: &discardTiles)
    }

    // SetDiscardTilesSlice 设置弃牌
    func setDiscardTilesSlice(s: [Card]) {
        addArray(s: s, to: &discardTiles)
    }

    // SetDiscardTilesMap 设置弃牌
    func setDiscardTilesMap(m: [Card: Int]) {
        discardTiles = m
    }

    // ShowDiscardTiles 显示弃牌
    func showDiscardTiles() -> [Card] {
        return arrayFrom(m: discardTiles)
    }

    // SetRemainTilesSlice 设置剩余的牌
    func setRemainTilesSlice(s: [Card]) {
        addArray(s: s, to: &remainTiles)
    }

    // SetRemainTilesMap 添加剩余的牌
    func setRemainTilesMap(m: [Card: Int]) {
        remainTiles = m
    }

    // DeductRemainTiles 扣除剩余的牌
    func deductRemainTiles(tiles: [Card]) {
        tiles.forEach { card in
            let cnt = remainTiles[card]
            if !remainTiles.keys.contains(where: { $0 == card }) {
                // showError("扣除剩余牌的数量错误, tile:%v", tile)
            }  else if cnt == 1 {
                remainTiles.removeValue(forKey: card)
            } else if let cnt = cnt {
                remainTiles[card] = cnt - 1
            }
        }
    }

    // ShowRemainTiles 显示剩余的牌
    func showRemainTiles() -> [Card] {
        return arrayFrom(m: remainTiles)
    }

    // CalcRemaimTiles 计算剩余的牌
    func calcRemaimTiles() {
        tiles.forEach { (key, value) in
            var cnt = value
            if let handTitlesCount = handTiles[key] {
                cnt -= handTitlesCount
            }
            if let showTilesCount = showTiles[key] {
                cnt -= showTilesCount
            }
            if let discardTilesCount = discardTiles[key] {
                cnt -= discardTilesCount
            }
            if cnt > 0 {
                remainTiles[key] = cnt
            } else if cnt < 0 {
                // showError("计算剩余牌的数量错误, tile:%v", tile)
            }
        }
    }

    // 读取给予的牌的剩余张数之和
    func getRemainTilesCnt(tiles: [Card]) -> Int {
        var cnt = 0
        tiles.unique.forEach { card in
            if let remainTitlesCount = remainTiles[card] {
                cnt += remainTitlesCount
            }
        }
        return cnt
    }

    // hasTile 是否有这张牌
    func hasTile(t: Card) -> Bool {
        return tiles.contains { (key, value) in
            return key == t
        }
    }

    // 判断是否有缺
    func hasLack() -> Bool {
        var hasLack = false
        if lack > .MAHJONG_PLACEHOLDER {
            handTiles.forEach { (key, value) in
                if key.IsSameType(lack) {
                    hasLack = true
                }
            }
        }
        return hasLack
    }

//    // 获取手牌中与某张牌有关联的牌
//    func isGuTile(tile: Card) -> Bool {
//        // 单张超过1张，不算故障
//        cnt, _ := ms.handTiles[tile]
//        if cnt > 1 {
//            return false
//        }
//        // 拥有有关联的牌，则不算孤张
//        for _, rTile := range card.GetRelationTiles(tile) {
//            if rTile == tile {
//                continue
//            }
//            if _, exists := ms.handTiles[rTile]; exists {
//                return false
//            }
//        }
//        return true
//    }
//
//    // 获取手牌中与某张牌是孤对
//    func (ms *MSelector) isGuPair(tile int) bool {
//        // 单张超过1张，不算故障
//        cnt, _ := ms.handTiles[tile]
//        if cnt != 2 {
//            return false
//        }
//        // 拥有有关联的牌，则不算孤张
//        for _, rTile := range card.GetRelationTiles(tile) {
//            if rTile == tile {
//                continue
//            }
//            if _, exists := ms.handTiles[rTile]; exists {
//                return false
//            }
//        }
//        return true
//    }
//
//    // 获取所有的孤张
//    func (ms *MSelector) getGuTiles() []int {
//        gTiles := make([]int, 0)
//        for tile := range ms.handTiles {
//            if ms.isGuTile(tile) {
//                gTiles = append(gTiles, tile)
//            }
//        }
//        return gTiles
//    }
//
//    // 获取所有的孤一对
//    func (ms *MSelector) getGuPairTiles() []int {
//        gpTiles := []int{}
//        for tile := range ms.handTiles {
//            if ms.isGuPair(tile) {
//                gpTiles = append(gpTiles, tile)
//            }
//        }
//        return gpTiles
//    }
    
    func mergeMap(m: [Card:Int], to map: inout [Card:Int]) {
        map = map.merging(m) { $0 + $1 }
    }
    
    func addArray(s: [Card], to map: inout [Card:Int]) {
        s.forEach { card in
            if let count = map[card] {
                map[card] = count + 1
            } else {
                map[card] = 1
            }
        }
    }
    
    func arrayFrom(m: [Card: Int]) -> [Card] {
        var s: [Card] = []
        m.forEach { (key, value) in
            var i = 0
            while i < value {
                s.append(key)
                i += 1
            }
        }
        s.sort()
        return s
    }

}
