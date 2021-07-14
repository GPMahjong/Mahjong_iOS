//
//  RoomViewController.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/2.
//

import UIKit

class RoomViewController: UIViewController {

    @IBOutlet weak var leadingPlaceholdView: UIView!
    @IBOutlet weak var trailingPlaceholdView: UIView!
    @IBOutlet weak var topPlaceholdView: UIView!
    @IBOutlet weak var bottomPlaceholdView: UIView!
    
    var roomManager: RoomManager
    
    private var localUserVC = DesktopViewController()
    private var firstUserVC = DesktopViewController()
    private var secondUserVC = DesktopViewController()
    private var thirdUserVC = DesktopViewController()
    
    init(_ selectedUser: [User]) {
        roomManager = RoomManager(selectedUser)
        super.init(nibName: "RoomViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomManager.setBookMaker()
        let unlocalUsers = roomManager.participants.filter { !$0.isLocalUser }
        for (index, p) in unlocalUsers.enumerated() {
            if index == 0 {
                firstUserVC.participant = p
            } else if index == 1 {
                secondUserVC.participant = p
            } else if index == 2 {
                thirdUserVC.participant = p
            }
        }
        localUserVC.participant = roomManager.localParticipant
        addSubviews()
    }
    
    private func addSubviews() {
        leadingPlaceholdView.addSubviewToFill(firstUserVC.view)
        topPlaceholdView.addSubviewToFill(secondUserVC.view)
        trailingPlaceholdView.addSubviewToFill(thirdUserVC.view)
        bottomPlaceholdView.addSubviewToFill(localUserVC.view)
    }

    @IBAction func didClickOnReadyButton(_ sender: Any) {
        roomManager.isReady = true
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
