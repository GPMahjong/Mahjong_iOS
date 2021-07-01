//
//  User.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

public class User {
    var peer: Peer?
    var avatar: UIImage? = UIImage(named: "photo")
    var isReady: Bool = false
    var name: String {
        if let peer = peer {
            return peer.name
        } else {
            return "default user"
        }
        
    }
    var userId: String {
        if let peer = peer {
            return peer.id
        } else {
            return "default userId"
        }
    }
    init(peer: Peer? = nil) {
        self.peer = peer
    }
}
