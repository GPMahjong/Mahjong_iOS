//
//  User.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

public class User {
    var peer: Peer
    var avatar: UIImage? = UIImage(named: "photo")
    var isReady: Bool = false
    var name: String {
        return peer.name
    }
    var userId: String {
        return peer.id
    }
    init(peer: Peer) {
        self.peer = peer
    }
}
