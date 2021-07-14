//
//  MPCManager.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

protocol MPCManagerDelegate: AnyObject {
    func didReceive(message: BasicMessage)
    func didAdded(user: User)
    func didRemoved(user: User)
    func didConnected()
    func didDisconnected()
}

protocol MPCManagerProtocol: AnyObject {
    func sendMessage(_ message: BasicMessage, to user: User)
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
        
        t.receive(MahjongPayload.self) { [weak self] payload, peer in
            self?.delegate?.didReceive(message: payload)
        }
        
        t.receive(ActionPayload.self) { [weak self] payload, peer in
            self?.delegate?.didReceive(message: payload)
        }
        
        t.peerAdded = didAdded(peer:)
        t.peerRemoved = didRemoved(peer:)
        return t
    }()
    
    init() {
        transceiver.resume()
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
        user.name = peer.name
        user.peerId = peer.id
        return user
    }
}

extension MPCManager: MPCManagerProtocol {
    func sendMessage(_ message: BasicMessage, to user: User) {
        guard let peer = transceiver.availablePeers.first(where: { $0.id == user.peerId }) else { return }
        if let message = message as? MessagePayload {
            transceiver.send(message, to: [peer])
        } else if let message = message as? ActionPayload {
            transceiver.send(message, to: [peer])
        } else if let message = message as? MahjongPayload {
            transceiver.send(message, to: [peer])
        }
    }
    
    func sendMessageToAll(_ message: BasicMessage) {
        guard !transceiver.availablePeers.isEmpty else { return }
        if let message = message as? MessagePayload {
            transceiver.send(message, to: transceiver.availablePeers)
        } else if let message = message as? ActionPayload {
            transceiver.send(message, to: transceiver.availablePeers)
        } else if let message = message as? MahjongPayload {
            transceiver.send(message, to: transceiver.availablePeers)
        }
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
    
    func didReceive(message: BasicMessage) {
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

