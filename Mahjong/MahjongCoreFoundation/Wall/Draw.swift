//
//  Draw.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/3.
//

import UIKit

class Draw {
    var wall: Wall = Wall()
    
    // GetFrowrdNextTile 获取下一张被抓的牌的牌面值
    func getFrowrdNextTile() -> Card {
        var index = 0
        // 当牌池只剩下最后一张牌时，需要根据前抓的张数和后抓的张数，拿到最后一张牌的索引
        // 如果后面抓了奇数张牌，则下张要抓的牌的索引，要向后移动一位
        if wall.forward+wall.backward == wall.length() - 1 && wall.backward % 2 == 1 {
            index = wall.forward + 1
        } else {
            index = wall.forward
        }
        return wall.getTile(index)
    }

    // ForwardDraw 从前面抓一张牌
    func forwardDraw() -> Card {
        defer {
            wall.forward += 1
        }
        return getFrowrdNextTile()
    }

    // ForwardDrawMulti 从前面抓N张牌
    func forwardDrawMulti(n: Int) -> [Card] {
        defer {
            wall.forward += n
        }
        return Array(wall.tiles[wall.forward...wall.forward+n])
    }

    // BackwardDraw 从后面抓牌
    // 根据wall.backword的当前值计算该拿的牌的
    // eg: 如果牌的总数是108张，牌是按照0 ~ 107的顺序摆的，上面的都是偶数张，下面的是奇数张
    // 如果只剩一张牌，若后面拿的是偶数张牌，那么直接拿就可以了；如果后面拿的是基数张，则拿forward+1(eg:后面未抓过时，107=this.forward+1，后面抓过一张的话，107=this.forward)
    // 如果wall.backword == 0, 此时从后面拿，应该是拿第106张
    // 如果wall.backword == 1, 此时从后面拿，应该是拿第107张
    // 如果wall.backword == 2, 此时从后面拿，应该是拿第104张
    // 如果wall.backword == 3, 此时从后面拿，应该是拿第105张
    func backwardDraw() -> Card {
        defer {
            wall.backward += 1
        }

        var index = 0
        if wall.forward + wall.backward == wall.length()-1 {
            // 如果只剩一张牌，那么就直接拿了
            if wall.backward % 2 == 1 {
                index = wall.forward + 1
            } else {
                index = wall.forward
            }
        } else if wall.backward%2 == 0 {
            // 如果从后面拿了偶数张，公式为：总张数-2-已抓张数
            index = (wall.length() - 2) - wall.backward
        } else {
            // 如果从后面拿了奇数张，公式为：总张数-已抓牌数
            index = wall.length() - wall.backward
        }
        return wall.getTile(index)
    }

    // IsAllDrawn 是否已经抓完了
    func isAllDrawn() -> Bool {
        return wall.forward + wall.backward >= wall.length()
    }

    // IsDrawn 某张牌是否被抓过
    // 需要考虑后面被抓奇数张的情况，如果牌总数是108，后面第一张抓的应该是106，107还在
    func isDrawn(_ index: Int) -> Bool {
        if index < wall.forward {
            return true
        }
        if wall.backward % 2 == 0 {
            return index >= wall.length() - wall.backward
        }
        return index >= wall.length() - wall.backward - 1 && index != wall.length() - wall.backward
    }
}
