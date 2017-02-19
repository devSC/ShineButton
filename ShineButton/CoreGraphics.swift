//
//  CoreGraphics.swift
//  ShineButton
//
//  Created by Wilson-Yuan on 2017/2/19.
//  Copyright © 2017年 Being Inc. All rights reserved.
//

import UIKit

class CoreGraphics: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        backgroundColor = UIColor.yellow
        let backgroundColors = [UIColor.gray, UIColor.black, UIColor.brown, UIColor.yellow]
        for i in 0..<4 {
            
            let shapeLayer = CAShapeLayer()
            //get center
            let width = self.bounds.width
            let height = self.bounds.height
            
            let center = CGPoint(x: width / 2, y: height / 2)
            //
            let radius: CGFloat = width / 2 * 0.8;
            let angle: CGFloat = CGFloat(45 * i);
            let resultAngle = angle * CGFloat(M_PI) / 180
            //
            let a = sin(resultAngle) * radius
            let b = cos(resultAngle) * radius
            
            //
            let cycleCenter = CGPoint(x: center.x + b, y: center.y - a)
            let path = UIBezierPath(arcCenter: cycleCenter, radius: 10, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: false)
            
            shapeLayer.strokeColor = UIColor.red.cgColor
            shapeLayer.fillColor = backgroundColors[i].cgColor
            //        shapeLayer.lineWidth = 10
            shapeLayer.path = path.cgPath
            shapeLayer.backgroundColor = UIColor.cyan.cgColor
            layer.addSublayer(shapeLayer)
        }
        //
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.

}
