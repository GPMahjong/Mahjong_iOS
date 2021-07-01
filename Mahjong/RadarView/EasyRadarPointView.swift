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
        }
    }
    
    var pointTapBlock: ((_ radarPointView: EasyRadarPointView) -> Void)?
    var angle: Int = 0 //角度
    var radius: Int = 0 //距离中心点的距离
    var icon: UIImageView?//小头像
    var nameLabel = { () -> UILabel in
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        icon = UIImageView(frame: self.bounds)
        self.addSubview(icon!)
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tapGesture)
        
        addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    @objc private func tapAction() {
        if self.pointTapBlock != nil {
            self.pointTapBlock!(self)
        }
    }
}

