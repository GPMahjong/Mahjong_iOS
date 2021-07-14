//
//  MahjongCenter.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/11.
//

import UIKit

protocol MahjongCenterProtol {
    // ForwardDrawMulti 从前面抓N张牌
    func forwardDrawMulti(n: Int) -> [Card]
    
    // ForwardDraw 从前面抓一张牌
    func forwardDraw() -> Card
}

class MahjongCenter {
    var draw = Draw()
    
    init() {
        draw.wall.setTiles(tiles: MahjongCards108)
    }
}

extension MahjongCenter: MahjongCenterProtol {
    func forwardDrawMulti(n: Int) -> [Card] {
        return draw.forwardDrawMulti(n: n)
    }
    
    func forwardDraw() -> Card {
        return draw.forwardDraw()
    }
}
