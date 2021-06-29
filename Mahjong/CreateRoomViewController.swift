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

    private lazy var transceiver: MultipeerTransceiver = {
        var config = MultipeerConfiguration.default
        config.serviceType = "Mahjong"
        config.security.encryptionPreference = .required

        let t = MultipeerTransceiver(configuration: config)
        t.receive(MessagePayload.self) { payload, peer in
            
        }
        return t
    }()

    private lazy var dataSource: MultipeerDataSource = {
        MultipeerDataSource(transceiver: transceiver)
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        dataSource = MultipeerDataSource(transceiver: <#T##MultipeerTransceiver#>)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRadarView()
        radarView.scan()
    }
    
    func setupRadarView() {
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
        
        for i in 1...20 {
            let delayTime = Double(i * 1)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayTime) {
                self.radarView.addPointView()
            }
            
        }
        
        //设置标注点击回调
        radarView.pointTapBlock = { (radarPointView) in
            print("tag:\(radarPointView.tag)")
            if let user = radarPointView.user {
                self.didClickOnUser(user)
            }
        }
    }
    
    func didClickOnUser(_ user: User) {
        print("\(#function) name = \(user.name)")
        
    }

}
