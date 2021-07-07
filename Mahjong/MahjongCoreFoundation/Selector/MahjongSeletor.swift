//
//  MahjongSeletor.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/7/7.
//

import UIKit

// MSelector 麻将选牌器
class MahjongSeletor: NSObject {
    
    var aiLevel: Int                // AI等级
    var tiles: [Card:Int]           // 所有牌
    var handTiles: [Card:Int]       // 手牌
    var discardTiles: [Card:Int]    // 弃牌
    var showTiles: [Card:Int]       // 明牌
    var remainTiles: [Card:Int]     // 剩余牌
    var lack: Card                  // 缺牌

    // Clean 清空选牌器
    func clean() {
        handTiles = [:]
        discardTiles = make(map[int]int, 0)
        showTiles = make(map[int]int, 0)
        remainTiles = make(map[int]int, 0)
        lack = 0
    }

    // SetAILevel 设置AI级别
    func (ms *MSelector) SetAILevel(level int) {
        ms.aiLevel = level
    }

    // SetLack 设置定缺
    func (ms *MSelector) SetLack(lack int) {
        ms.lack = lack
    }

    // GetLack 设置定缺
    func (ms *MSelector) GetLack() int {
        return ms.lack
    }

    // GetTiles 设置所有的牌
    func (ms *MSelector) GetTiles() map[int]int {
        return ms.tiles
    }

    // GetShuffleTiles 获取打乱排序的牌
    func (ms *MSelector) GetShuffleTiles() []int {
        return util.ShuffleSliceInt(util.MapToSlice(ms.tiles))
    }

    // SetTiles 设置所有的牌
    func (ms *MSelector) SetTiles(s []int) {
        ms.tiles = util.SliceToMap(s)
    }

    // AddHandTilesMap 添加手牌
    func (ms *MSelector) AddHandTilesMap(m map[int]int) {
        ms.handTiles = util.MergeMap(ms.handTiles, m)
    }

    // AddHandTilesSlice 添加手牌
    func (ms *MSelector) AddHandTilesSlice(s []int) {
        ms.handTiles = util.MergeMap(ms.handTiles, util.SliceToMap(s))
    }

    // SetHandTilesSlice 设置手牌
    func (ms *MSelector) SetHandTilesSlice(s []int) {
        ms.handTiles = util.SliceToMap(s)
    }

    // SetHandTilesMap 设置手牌
    func (ms *MSelector) SetHandTilesMap(m map[int]int) {
        ms.handTiles = m
    }

    // ShowHandTiles 显示手牌
    func (ms *MSelector) ShowHandTiles() []int {
        s := util.MapToSlice(ms.handTiles)
        sort.Ints(s)
        return s
    }

    // AddShowTilesSlice 添加明牌
    func (ms *MSelector) AddShowTilesSlice(s []int) {
        ms.showTiles = util.MergeMap(ms.showTiles, util.SliceToMap(s))
    }

    // AddShowTilesMap 添加明牌
    func (ms *MSelector) AddShowTilesMap(m map[int]int) {
        ms.showTiles = util.MergeMap(ms.showTiles, m)
    }

    // SetShowTilesSlice 添加明牌
    func (ms *MSelector) SetShowTilesSlice(s []int) {
        ms.showTiles = util.SliceToMap(s)
    }

    // SetShowTilesMap 添加明牌
    func (ms *MSelector) SetShowTilesMap(m map[int]int) {
        ms.showTiles = m
    }

    // ShowShowTiles 显示明牌
    func (ms *MSelector) ShowShowTiles() []int {
        s := util.MapToSlice(ms.showTiles)
        sort.Ints(s)
        return s
    }

    // AddDiscardTilesSlice 添加弃牌
    func (ms *MSelector) AddDiscardTilesSlice(s []int) {
        ms.discardTiles = util.MergeMap(ms.discardTiles, util.SliceToMap(s))
    }

    // AddDiscardTilesMap 添加弃牌
    func (ms *MSelector) AddDiscardTilesMap(m map[int]int) {
        ms.discardTiles = util.MergeMap(ms.discardTiles, m)
    }

    // SetDiscardTilesSlice 设置弃牌
    func (ms *MSelector) SetDiscardTilesSlice(s []int) {
        ms.discardTiles = util.SliceToMap(s)
    }

    // SetDiscardTilesMap 设置弃牌
    func (ms *MSelector) SetDiscardTilesMap(m map[int]int) {
        ms.discardTiles = m
    }

    // ShowDiscardTiles 显示明牌
    func (ms *MSelector) ShowDiscardTiles() []int {
        s := util.MapToSlice(ms.discardTiles)
        sort.Ints(s)
        return s
    }

    // SetRemainTilesSlice 设置剩余的牌
    func (ms *MSelector) SetRemainTilesSlice(s []int) {
        ms.remainTiles = util.SliceToMap(s)
    }

    // SetRemainTilesMap 添加剩余的牌
    func (ms *MSelector) SetRemainTilesMap(m map[int]int) {
        ms.remainTiles = m
    }

    // DeductRemainTiles 扣除剩余的牌
    func (ms *MSelector) DeductRemainTiles(tiles ...int) {
        for _, t := range tiles {
            cnt, exists := ms.remainTiles[t]
            if !exists {
                // showError("扣除剩余牌的数量错误, tile:%v", tile)
            } else if cnt == 1 {
                delete(ms.remainTiles, t)
            } else {
                ms.remainTiles[t]--
            }
        }
    }

    // ShowRemainTiles 显示剩余的牌
    func (ms *MSelector) ShowRemainTiles() []int {
        s := util.MapToSlice(ms.remainTiles)
        sort.Ints(s)
        return s
    }

    // CalcRemaimTiles 计算剩余的牌
    func (ms *MSelector) CalcRemaimTiles() {
        ms.remainTiles = make(map[int]int, 0)
        for t, cnt := range ms.tiles {
            cnt -= ms.handTiles[t]
            cnt -= ms.showTiles[t]
            cnt -= ms.discardTiles[t]

            if cnt > 0 {
                ms.remainTiles[t] = cnt
            } else if cnt < 0 {
                // showError("计算剩余牌的数量错误, tile:%v", tile)
            }
        }
    }

    // 读取给予的牌的剩余张数之和
    func (ms *MSelector) getRemainTilesCnt(tiles []int) int {
        cnt := 0
        for _, t := range util.SliceUniqueInt(tiles) {
            cnt += ms.remainTiles[t]
        }
        return cnt
    }

    // hasTile 是否有这张牌
    func (ms *MSelector) hasTile(t int) bool {
        _, exists := ms.tiles[t]
        return exists
    }

    // 判断是否有缺
    func (ms *MSelector) hasLack() bool {
        if ms.lack > 0 {
            for tile := range ms.handTiles {
                if card.IsSameType(tile, ms.lack) {
                    return true
                }
            }
        }
        return false
    }

    // 获取手牌中与某张牌有关联的牌
    func (ms *MSelector) isGuTile(tile int) bool {
        // 单张超过1张，不算故障
        cnt, _ := ms.handTiles[tile]
        if cnt > 1 {
            return false
        }
        // 拥有有关联的牌，则不算孤张
        for _, rTile := range card.GetRelationTiles(tile) {
            if rTile == tile {
                continue
            }
            if _, exists := ms.handTiles[rTile]; exists {
                return false
            }
        }
        return true
    }

    // 获取手牌中与某张牌是孤对
    func (ms *MSelector) isGuPair(tile int) bool {
        // 单张超过1张，不算故障
        cnt, _ := ms.handTiles[tile]
        if cnt != 2 {
            return false
        }
        // 拥有有关联的牌，则不算孤张
        for _, rTile := range card.GetRelationTiles(tile) {
            if rTile == tile {
                continue
            }
            if _, exists := ms.handTiles[rTile]; exists {
                return false
            }
        }
        return true
    }

    // 获取所有的孤张
    func (ms *MSelector) getGuTiles() []int {
        gTiles := make([]int, 0)
        for tile := range ms.handTiles {
            if ms.isGuTile(tile) {
                gTiles = append(gTiles, tile)
            }
        }
        return gTiles
    }

    // 获取所有的孤一对
    func (ms *MSelector) getGuPairTiles() []int {
        gpTiles := []int{}
        for tile := range ms.handTiles {
            if ms.isGuPair(tile) {
                gpTiles = append(gpTiles, tile)
            }
        }
        return gpTiles
    }

}
