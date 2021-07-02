//
//  EasyRadarPointView.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit

open class EasyRadarPointView: UIView {
    
    public var user: User? {
        didSet {
            nameLabel.text = user?.name
            icon?.image = user?.avatar
        }
    }
    
    var pointTapBlock: ((_ radarPointView: EasyRadarPointView) -> Void)?
    var angle: Int = 0 //角度
    var radius: Int = 0 //距离中心点的距离
    var icon: UIImageView?//小头像
    var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    private var backgroundButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        backgroundColor = UIColor.gray
        icon = UIImageView(frame: bounds)
        addSubview(icon!)
        
        nameLabel.frame = bounds
        addSubview(nameLabel)
        
        backgroundButton.frame = bounds
        addSubview(backgroundButton)
    }
    
    @objc private func tapAction(sender: UIButton) {
        pointTapBlock?(self)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("point \(#function)")
    }
}

