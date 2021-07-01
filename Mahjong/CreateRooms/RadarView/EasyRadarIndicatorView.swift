//
//  EasyRadarIndicatorView.swift
//  Mahjong
//
//  Created by Tao, Wang on 2021/6/29.
//

import UIKit

class EasyRadarIndicatorView: UIView {
    var radius: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        debug_log("开始绘制指针")
        let context = UIGraphicsGetCurrentContext()
        let whiteColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha:0.8)
        context?.setFillColor(whiteColor.cgColor)
        context?.setLineWidth(0)
        context?.move(to: CGPoint(x: rect.width / 2, y: self.center.y))
        context?.addArc(center: CGPoint(x: rect.width / 2, y: self.center.y), radius: self.radius, startAngle: CGFloat(-90.5 * .pi / 180), endAngle: CGFloat(-90 * Double.pi / 180), clockwise: false)
        context?.closePath()
        context?.drawPath(using: CGPathDrawingMode.fillStroke)
        
        for i in 0...270 {
            let color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: CGFloat(i)/500)
            context?.setFillColor(color.cgColor)
            context?.setLineWidth(0)
            context?.move(to: CGPoint(x: rect.width / 2, y: self.center.y))
            context?.addArc(center: CGPoint(x: rect.width / 2, y: self.center.y), radius: self.radius, startAngle: CGFloat(Double(-360 + i) * Double.pi / 180), endAngle: CGFloat(Double(-360 + i - 1) * Double.pi / 180), clockwise: true)
            context?.closePath()
            context?.drawPath(using: CGPathDrawingMode.fillStroke)
        }
    }
}
