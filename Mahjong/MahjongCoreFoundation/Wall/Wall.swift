//
//  Wall.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/3.
//

import UIKit

// Wall 牌墙
class Wall {
    var tiles:[Card] = []
    var forward: Int = 0  // 前游标
    var backward: Int = 0   // 后游标
}

extension Wall {

    // GetForward 获取前游标
    func getForward() -> Int {
        return forward
    }

    // GetBackwoad 获取后游标
    func getBackwoad() -> Int {
        return backward
    }

    // SetTiles 设置牌墙的牌
    func setTiles(tiles: [Card]) {
        self.tiles = tiles
    }

    // GetTile 取某个索引的牌面值
    func getTile(_ index: Int) -> Card {
        guard !tiles.isEmpty else { return .MAHJONG_PLACEHOLDER }
        return tiles[index]
    }

    // GetTiles 获取牌墙所有的牌
    func getTiles() -> [Card] {
        return tiles
    }

    // Shuffle 洗牌
    func shuffle() {
        tiles = shuffleTiles(tiles)
    }

    // Length 获取牌墙长度
    func length() -> Int {
        return tiles.count
    }

    // RemainLength 牌墙剩余张数
    func remainLength() -> Int {
        return length() - forward - backward
    }
    
    func shuffleTiles(_ arr:[Card]) -> [Card] {
        var data:[Card] = arr
        for i in 1..<arr.count {
            let index:Int = Int(arc4random()) % i
            if index != i {
                swap(&data[i], &data[index])
            }
        }
        return data
    }
}
