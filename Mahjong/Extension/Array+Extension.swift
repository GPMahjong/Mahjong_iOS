//
//  Array+Extension.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/7/6.
//

extension Array where Element:Hashable {
    var unique:[Element] {
        var uniq = Set<Element>()
        uniq.reserveCapacity(self.count)
        return self.filter {
            return uniq.insert($0).inserted
        }
    }
}

extension Array {
    subscript (safe index: Index) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
}
