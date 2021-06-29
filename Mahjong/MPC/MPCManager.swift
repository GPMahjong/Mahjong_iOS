//
//  MPCManager.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

protocol MPCManagerDelegate {
    func didReceiveMessage(message: MessagePayload)
    
}

class MPCManager: NSObject {
    
    var delegate: MPCManagerDelegate?
    

    private lazy var transceiver: MultipeerTransceiver = {
        var config = MultipeerConfiguration.default
        config.serviceType = "Mahjong"
        config.security.encryptionPreference = .required

        let t = MultipeerTransceiver(configuration: config)
        t.receive(MessagePayload.self) { payload, peer in
            
        }
        
//        t.peerAdded = 
//        t.peerRemoved =
        return t
    }()

    private lazy var dataSource: MultipeerDataSource = {
        MultipeerDataSource(transceiver: transceiver)
    }()
    
    
    
}
