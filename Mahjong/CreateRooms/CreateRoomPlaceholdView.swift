//
//  CreateRoomPlaceholdView.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/1.
//

import UIKit

class CreateRoomPlaceholdView: UIView {

    let placeholdString = "快来打麻将"
    
    var user: User? {
        didSet {
            isPlacehold = false
        }
    }
    
    private var isPlacehold: Bool = true {
        didSet {
            if isPlacehold {
                nameLabel.text = placeholdString
                backgroundColor = UIColor.green
            } else {
                nameLabel.text = user?.name
                backgroundColor = UIColor.orange
            }
        }
    }
    
    private var nameLabel = UILabel(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubview()
    }
    
    private func initSubview() {
        translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        isPlacehold = true
    }

}
