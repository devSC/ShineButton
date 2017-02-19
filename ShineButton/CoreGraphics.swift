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

class SineView: UIView{
    let graphWidth: CGFloat = 0.8  // Graph is 80% of the width of the view
    let amplitude: CGFloat = 0.3   // Amplitude of sine wave is 30% of view height
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let origin = CGPoint(x: width * (1 - graphWidth) / 2, y: height * 0.50)
        
        let path = UIBezierPath()
        path.move(to: origin)
        
        for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
            let x = origin.x + CGFloat(angle/360.0) * width * graphWidth
            let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * height * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        UIColor.black.setStroke()
        path.stroke()
    }
}
