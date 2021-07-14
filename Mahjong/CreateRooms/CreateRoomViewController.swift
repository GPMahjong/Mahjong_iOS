//
//  CreateRoomViewController.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit
import MultipeerKit

class CreateRoomViewController: UIViewController {
    
    @IBOutlet weak var radarView: EasyRadarView!
    @IBOutlet weak var firstManView: CreateRoomPlaceholdView!
    @IBOutlet weak var secondManView: CreateRoomPlaceholdView!
    @IBOutlet weak var thirdManView: CreateRoomPlaceholdView!
    @IBOutlet weak var fouthManView: CreateRoomPlaceholdView!
    
    var selectedUsers: [User] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MPCManager.shareInstance.delegate = ConnectManagerDelegateWeakObject([self])
        MPCManager.shareInstance.resume()
        setupRadarView()
        radarView.scan()
    }
    
    private func setupRadarView() {
        //设置是否开启调试日志
        EasyRadarView.enableLog = true
        //设置背景图
        radarView.bgImage = UIImage(named: "radar_bg")
        //设置中心视图图片
        radarView.centerViewImage = UIImage(named: "photo")
        //设置圈数
        radarView.circleNum = 3
        //设置指针半径
        radarView.indicatorViewRadius = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 2 - 24
        //设置每个圈与圈的增量距离
        radarView.circleIncrement = 10.0
        
        //设置标注点击回调
        radarView.pointTapBlock = { (radarPointView) in
            print("tag:\(radarPointView.tag)")
            if let user = radarPointView.user {
                self.didClickOnUser(user)
            }
        }
    }
    
    private func updatePlaceholdView() {
        firstManView.user = User.localUser()
        if let user = selectedUsers[safe: 0] {
            secondManView.user = user
        }
        if let user = selectedUsers[safe: 1] {
            thirdManView.user = user
        }
        if let user = selectedUsers[safe: 2] {
            fouthManView.user = user
        }
    }
    
    //MARK: - Action
    private func didClickOnUser(_ user: User) {
        print("\(#function) name = \(user.name)")
        if !selectedUsers.compactMap({ $0.uuid }).contains(user.uuid) {
            selectedUsers.append(user)
        }
        updatePlaceholdView()
    }
    
    @IBAction func didClickOnCreateRoomButton(_ sender: Any) {
        let messgae = MessagePayload.createRoomMessage()
        messgae.participants = selectedUsers
        MPCManager.shareInstance.sendMessageToAll(messgae)
        
        let roomVC = RoomViewController(selectedUsers)
        navigationController?.pushViewController(roomVC, animated: true)
    }
}

//MARK: - MPCManagerDelegate
extension CreateRoomViewController: MPCManagerDelegate {
    
    func didAdded(user: User) {
        radarView.addPointView(user)
    }
    
    func didRemoved(user: User) {
        radarView.removePointView(user)
    }
    
    
    func didConnected() { }
    
    func didDisconnected() { }
    
    func didReceive(message: BasicMessage) {
        if let message = message as? MessagePayload {
            handleMessagePayload(message)
        } else if let action = message as? ActionPayload {
            handleActionPayload(action)
        } else if let mahjong = message as? MahjongPayload {
            handleMahjongPayload(mahjong)
        }
    }
    
    func handleMessagePayload(_ message: MessagePayload) {
        if message.type == .createRoom {
            let roomVC = RoomViewController(selectedUsers)
            navigationController?.pushViewController(roomVC, animated: true)
        }
    }
    
    func handleActionPayload(_ message: ActionPayload) {
        
    }
    
    func handleMahjongPayload(_ mahjong: MahjongPayload) {
        
    }
    
}
