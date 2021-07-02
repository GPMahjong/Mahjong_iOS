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
    var name: String = ""
    var id: String = ""
    var isLocalUser: Bool = false
    
    
    static func localUser() -> User {
        let user = User()
        user.name = UIDevice.current.name
        user.id = UIDevice.current.identifierForVendor?.uuidString ?? ""
        user.isLocalUser = true
        return user
    }
}

public class Participant {
    var user: User
    var isReady: Bool = false
    var isHomeowner: Bool = false
    var isBoolmarker: Bool = false
    init(_ user: User) {
        self.user = user
    }
}
