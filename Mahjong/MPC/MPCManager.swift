//
//  MPCManager.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

protocol ConnectManagerDelegate {
    func didReceive(message: MessagePayload)
    func didAdded(user: User)
    func didRemoved(user: User)
    func didConnected()
    func didDisconnected()
}

class MPCManager {
    
    var delegate: ConnectManagerDelegate?
    
    private lazy var transceiver: MultipeerTransceiver = {
        var config = MultipeerConfiguration.default
        config.serviceType = "Mahjong"
        config.security.encryptionPreference = .required

        let t = MultipeerTransceiver(configuration: config)
        t.receive(MessagePayload.self) { [weak self] payload, peer in
            self?.delegate?.didReceive(message: payload)
        }
        
        t.peerAdded = didAdded(peer:)
        t.peerRemoved = didRemoved(peer:)
        return t
    }()

    private lazy var dataSource: MultipeerDataSource = {
        MultipeerDataSource(transceiver: transceiver)
    }()
    
    init() {
        dataSource.transceiver.resume()
    }
    
    func didAdded(peer: Peer) {
        delegate?.didAdded(user: User(peer: peer))
    }
    
    func didRemoved(peer: Peer) {
        delegate?.didRemoved(user: User(peer: peer))
    }
    
    func resume() {
        transceiver.resume()
    }
    
}
