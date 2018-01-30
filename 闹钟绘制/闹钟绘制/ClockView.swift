//
//  ClockView.swift
//  闹钟绘制
//
//  Created by yurong on 2018/1/29.
//  Copyright © 2018年 yurong. All rights reserved.
//

import UIKit

class ClockView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var currentPoint:Float = 0 
    fileprivate var boundsSize:CGSize = CGSize.zero
    
    func startAnimation() {
        //旋转动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 3
        animation.fromValue = 0
        animation.toValue = currentPoint/10*Float(Double.pi)
        //animation.autoreverses = true//动画返回
        //动画结束不返回原位置
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        let frame = pointerLayer.frame
        pointerLayer.anchorPoint = CGPoint(x: 0.5, y: 1 )
        pointerLayer.frame = frame
        pointerLayer.add(animation, forKey: "start")
    }
    override func awakeFromNib() {
        boundsSize = self.bounds.size
        
        
        layer.addSublayer(arcLayer)
        layer.addSublayer(pointerLayer)
        layer.addSublayer(centerPointerLayer)
        addDetailLine()
    }
    
    
    /// 刻线
    func addDetailLine() {
        let angle = Double.pi/10
        
        for num in 0...10 {
            
            let x = boundsSize.width/2 - cos(CGFloat(angle)*CGFloat(num))*boundsSize.width/2
            let y = boundsSize.height - sin(CGFloat(angle)*CGFloat(num))*boundsSize.width/2
            let path = UIBezierPath()
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: boundsSize.width/2, y: boundsSize.height))
            
            let numlayer = CAShapeLayer()
            numlayer.path = path.cgPath
            numlayer.fillColor = UIColor.clear.cgColor
            numlayer.strokeColor = UIColor.red.cgColor
            layer.addSublayer(numlayer)
            //三个关键点
            
            if num == 0 || num == 5 || num == 10 {
                numlayer.strokeEnd = 0.1
            }else{
                numlayer.strokeEnd = 0.05
            }

        }
    }
    
    //MARK: 半圆
    lazy var arcLayer: CAShapeLayer = {
        let path = UIBezierPath(arcCenter: CGPoint(x: boundsSize.width/2, y: boundsSize.height), radius: boundsSize.width/2, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
        return layer
    }()
    //MARK: 指针
    lazy var pointerLayer: CAShapeLayer = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: boundsSize.width/2*0.6, y: boundsSize.height))
        path.addLine(to: CGPoint(x: boundsSize.width/2, y: boundsSize.height))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.frame = self.bounds
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
    
        return layer
    }()
    //MARK:圆心
    lazy var centerPointerLayer: CAShapeLayer = {
        let path = UIBezierPath(arcCenter: CGPoint(x: boundsSize.width/2, y: boundsSize.height), radius: 2, startAngle: 0, endAngle: CGFloat(Double.pi)*2, clockwise: false)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.red.cgColor
        
        return layer
    }()

    
}
