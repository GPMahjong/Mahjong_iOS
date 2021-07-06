//
//  MPCManager.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

protocol MPCManagerDelegate: AnyObject {
    func didReceive(message: MessagePayload)
    func didAdded(user: User)
    func didRemoved(user: User)
    func didConnected()
    func didDisconnected()
}

protocol MPCManagerProtocol: AnyObject {
    func sendMessageToClient(_ user: User)
    func sendMessageToAll(_ message: BasicMessage)
}

class MPCManager {
    static let shareInstance = MPCManager()
    var delegate: ConnectManagerDelegateWeakObject?
    
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
        delegate?.didAdded(user: createUser(peer))
    }
    
    func didRemoved(peer: Peer) {
        delegate?.didRemoved(user: createUser(peer))
    }
    
    func resume() {
        transceiver.resume()
    }
    
    func createUser(_ peer: Peer) -> User {
        let user = User()
        user.peer = peer
        user.name = peer.name
        user.id = peer.id
        return user
    }
    
}

// MARK: - ConnectManagerDelegateWeakObject
class ConnectManagerDelegateWeakObject : MPCManagerDelegate {
    
    private let multiDelegate: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    init(_ delegates: [MPCManagerDelegate]) {
        delegates.forEach { multiDelegate.add($0) }
    }

    // 遍历所有遵守协议的类
    private func invoke(_ invocation: (MPCManagerDelegate) -> Void) {
        for delegate in multiDelegate.allObjects.reversed() {
            invocation(delegate as! MPCManagerDelegate)
        }
    }
    // 添加遵守协议的类
    func add(_ delegate: MPCManagerDelegate) {
        multiDelegate.add(delegate)
    }
    
    // 删除指定遵守协议的类
    func remove(_ delegateToRemove: MPCManagerDelegate) {
        invoke {
            if $0 === delegateToRemove as AnyObject {
                multiDelegate.remove($0)
            }
        }
    }
    
    // 删除所有遵守协议的类
    func removeAll() {
        multiDelegate.removeAllObjects()
    }
    
    func didReceive(message: MessagePayload) {
        invoke { $0.didReceive(message: message)}
    }
    
    func didAdded(user: User) {
        invoke { $0.didAdded(user: user)}
    }
    
    func didRemoved(user: User) {
        invoke { $0.didRemoved(user: user)}
    }
    
    func didConnected() {
        invoke { $0.didConnected()}
    }
    
    func didDisconnected() {
        invoke { $0.didDisconnected()}
    }
}

