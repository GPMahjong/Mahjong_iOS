//
//  User.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

public class User: Codable {
//    var avatar: UIImage? = UIImage(named: "photo")
    var name: String = ""
    var uuid: String = ""
    var peerId: String = ""
    var isLocalUser: Bool {
        return uuid == UIDevice.current.identifierForVendor?.uuidString
    }
    
    static func localUser() -> User {
        let user = User()
        user.name = UIDevice.current.name
        user.uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        return user
    }
}

public class Participant {
    var user: User
    var selector = MahjongSeletor()
    var isReady: Bool = false
    var isHomeowner: Bool = false
    var isBoolmarker: Bool = false
    var isActive: Bool = false
    var isLocalUser: Bool {
        return user.isLocalUser
    }
    init(_ user: User) {
        self.user = user
    }
}
