//
//  RoomViewController.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/2.
//

import UIKit

class RoomViewController: UIViewController {

    var participants: [Participant] = []
    
    init(_ selectedUser: [User]) {
        participants = selectedUser.map({ Participant($0) })
        super.init(nibName: "RoomViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MPCManager.shareInstance.delegate?.add(self)
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RoomViewController: ConnectManagerDelegate {
    func didReceive(message: MessagePayload) {
        
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
