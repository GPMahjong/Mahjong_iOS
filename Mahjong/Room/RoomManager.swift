//
//  RoomManager.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/2.
//

import UIKit

class RoomManager {
    var participants: [Participant]
    var localParticipant: Participant
    var bookMkerParticipant: Participant?
    var mahjongCenter = MahjongCenter()
    var isReady: Bool = false {
        didSet {
            localParticipant.isReady = isReady
            MPCManager.shareInstance.sendMessageToAll(MessagePayload.isReadyMessage())
        }
    }
    
    init(_ selectedUser: [User]) {
        participants = selectedUser.map({ Participant($0) })
        localParticipant = participants.first { $0.user.isLocalUser } ?? Participant(User.localUser())
        MPCManager.shareInstance.delegate?.add(self)
    }
}

//MARk: - MPCManagerDelegate
extension RoomManager: MPCManagerDelegate {
    func didReceive(message: BasicMessage) {
        if let message = message as? MessagePayload {
            handleMessagePayload(message)
        } else if let action = message as? ActionPayload {
            handleActionPayload(action)
        } else if let mahjong = message as? MahjongPayload {
            handleMahjongPayload(mahjong)
        }
    }
    
    func didAdded(user: User) {
        
    }
    
    func didRemoved(user: User) {
        
    }
    
    func didConnected() {
        
    }
    
    func didDisconnected() {
        
    }
}

//MARK: - Handle Message
extension RoomManager {
    func handleMessagePayload(_ message: MessagePayload) {
        switch message.type {
        case .isReady:
            isReadyAction(message)
        case .createRoom:
            createRoomAction(message)
        case .bookMaker:
            bookMakerAction()
        default:
            isReadyAction(message)
        }
    }
    
    func handleActionPayload(_ message: ActionPayload) {
        
    }
    
    func handleMahjongPayload(_ mahjong: MahjongPayload) {
        
    }
    
    func isReadyAction(_ message: MessagePayload) {
        participants.forEach { participant in
            if participant.user.uuid == message.uuid {
                participant.isReady = true
            }
        }
        let isAllReady = participants.filter { !$0.isReady }.isEmpty
        if isAllReady,localParticipant.isBoolmarker {
            beginGame()
        }
    }
    
    func createRoomAction(_ message: MessagePayload) {
        
    }
    
    func bookMakerAction() {
        localParticipant.isBoolmarker = true
    }
}

//MARk: - Playgame
extension RoomManager {
    func beginGame() {
        //1. 掷骰子
        //2. 定庄家
        //3. 抓牌
        //骰子逻辑暂时省略
        drawCards()
    }
    
    func drawCards() {
        participants.forEach { p in
            p.selector.setTiles(s: mahjongCenter.draw.wall.tiles)
            if p.isLocalUser {
                let local = mahjongCenter.forwardDrawMulti(n: 14)
                p.selector.setHandTilesSlice(s: local)
                localParticipant.isActive = true
            } else {
                let handTiles = mahjongCenter.forwardDrawMulti(n: 13)
                p.selector.setHandTilesSlice(s: handTiles)
                
                let message = MahjongPayload()
                message.tiles = mahjongCenter.draw.wall.tiles
                message.handTiles = handTiles
                MPCManager.shareInstance.sendMessage(message, to: p.user)
            }
        }
    }
    
    func setBookMaker() {
//        let bookMakerIndex: Int = Int(arc4random()) % participants.count
        let bookMakerIndex: Int = 0
        let bookMaker = participants[bookMakerIndex]
        bookMaker.isBoolmarker = true
        bookMkerParticipant = bookMaker
        if bookMaker.isLocalUser {
            localParticipant.isBoolmarker = true
        } else {
            MPCManager.shareInstance.sendMessageToAll(MessagePayload.bookMakerMessage(bookMaker.user))
        }
    }
}
