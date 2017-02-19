//
//  ShineAngleLayer.swift
//  ShineButton
//
//  Created by Wilson-Yuan on 2017/2/18.
//  Copyright © 2017年 Being Inc. All rights reserved.
//

import UIKit

class ShineAngleLayer: CALayer {
    
    var params = ShineParams()
    
    var shineLayers = [CAShapeLayer]()
    
    var smallShineLayers = [CAShapeLayer]()
    
    var displayLink: CADisplayLink?
    
    
    init(frame: CGRect, params: ShineParams) {
        super.init()
        
        self.frame = frame
        self.params = params
        
        addShine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShineAngleLayer {
    //MARK: Public method
    func startAnimation() -> Void {
        
        let radius = frame.size.width / 2 * CGFloat(params.shineDistanceMultiple * 1.4)
        var startAngle: CGFloat = 0
        let angle = CGFloat(M_PI * 2 / Double(params.shineCount)) + startAngle
        
        //如果是奇数
        if params.shineCount % 2 != 0 {
            startAngle = CGFloat(M_PI * 2 - Double(angle) / Double(params.shineCount))
        }
        
        for i in 0..<params.shineCount {
            
            let bigShine = shineLayers[i]
            let bigAnim = angleAniamtion(for: bigShine, angle: startAngle + CGFloat(angle) * CGFloat(i), radius: radius)
            
            let smallShine = smallShineLayers[i]
            var radiusSub = frame.size.width * 0.15 * 0.66
            
            if params.shineSize != 0 {
                radiusSub = params.shineSize * 0.66
            }
            
            let smallAnim = angleAniamtion(for: smallShine, angle: startAngle + angle * CGFloat(i) - CGFloat(params.smallShineOffsetAngle) * CGFloat(M_PI) / 180, radius: radius - radiusSub)
            
            bigShine.add(bigAnim, forKey: "path")
            smallShine.add(smallAnim, forKey: "path")
            
            if params.enableFlashing {
                let bigFlash = flashAnimation()
                let smallFlash = flashAnimation()
                bigShine.add(bigFlash, forKey: "bigFlash")
                smallShine.add(smallFlash, forKey: "smallFlash")
            }
        }
        
        let angleAnim = CABasicAnimation(keyPath: "transform.rotation")
        angleAnim.duration = params.animDuration * 0.87
        angleAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        angleAnim.fromValue = 0
        angleAnim.toValue = CGFloat(params.shineTurnAngle) * CGFloat(M_PI) / 180
        angleAnim.delegate = self
        add(angleAnim, forKey: "rotate")
        
        if params.enableFlashing {
            startFlash()
        }
    }
}

private extension ShineAngleLayer {
    
    func startFlash() -> Void {
        
        displayLink = CADisplayLink(target: self, selector: #selector(flashAction))
        if #available(iOS 10.0, *) {
            displayLink?.preferredFramesPerSecond = 10
        }else {
            displayLink?.frameInterval = 6
        }
        displayLink?.add(to: .current, forMode: .commonModes)

    }
    
    
    @objc func flashAction() -> Void {
        for i in 0..<params.shineCount {
            let bigShine = shineLayers[i]
            let smallShine = smallShineLayers[i]
            bigShine.fillColor = params.colorRandom[Int(arc4random())%params.colorRandom.count].cgColor
            smallShine.fillColor = params.colorRandom[Int(arc4random())%params.colorRandom.count].cgColor
        }
    }
    
    func angleAniamtion(`for` shine: CAShapeLayer, angle: CGFloat, radius: CGFloat) -> CABasicAnimation {
        
        let anim = CABasicAnimation(keyPath: "path")
        anim.duration = params.animDuration * 0.87
        anim.fromValue = shine.path
        
        //new path and center
        let center = shineCenter(at: angle, radius: radius)
        let path = UIBezierPath(arcCenter: center, radius: 0.1, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: false)
        
        anim.toValue = path.cgPath
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        return anim
    }
    
    func flashAnimation() -> CABasicAnimation {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.fromValue = 1
        flash.toValue = 0
        
        let duration = Double(arc4random() % 20 + 60) / 1000
        flash.duration = duration
        flash.repeatCount = MAXFLOAT
        flash.isRemovedOnCompletion = false
        flash.autoreverses = true
        flash.fillMode = kCAFillModeForwards
        
        return flash
    }
    
    ///angle 为最终转换的弧度 angle = 角度 * M_P1 / 180
    func shineCenter(at angle: CGFloat, radius: CGFloat) -> CGPoint {
        
        let centX = bounds.midX
        let centY = bounds.midY
        //计算y或x值
        let sina = sin(angle) * radius
        //计算x或y值
        let cosb = cos(angle) * radius
        let point = CGPoint(x: centX + cosb, y: centY - sina)
        
        return point
    }
    
    
    func addShine() -> Void {
        
        var startAngle: CGFloat = 0
        
        //平均每个弧度
        let angle = CGFloat(M_PI * 2 / Double(params.shineCount)) + startAngle
        
        //奇数
        if params.shineCount % 2 != 0 {
            //向后偏移1/2个angle
            startAngle = CGFloat(M_PI * 2 - Double(angle) / Double(params.shineCount))
        }
        
        let radius = frame.size.width / 2 * CGFloat(params.shineDistanceMultiple)
        for i in 0..<params.shineCount {
            
            let bigShine = CAShapeLayer()
            var bigWidth = frame.size.width * 0.15 //
            
            if params.shineSize != 0 {
                bigWidth = params.shineSize
            }
            
            let center = shineCenter(at: startAngle + CGFloat(angle) * CGFloat(i), radius: radius)
            
            //draw small arc
            let path = UIBezierPath(arcCenter: center, radius: bigWidth, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: false)
            bigShine.path = path.cgPath
            
            if params.allowRandomColor {
                let index = Int(arc4random()) % params.colorRandom.count
                bigShine.fillColor = params.colorRandom[index].cgColor
            } else {
                bigShine.fillColor = params.bigShineColor.cgColor
            }
            
            addSublayer(bigShine)
            shineLayers.append(bigShine)
            
            //small
            let smallShine = CAShapeLayer()
            let smallWidth = bigWidth * 0.66
            let smallCenter = shineCenter(at: startAngle + CGFloat(angle) * CGFloat(i) - CGFloat(params.smallShineOffsetAngle) * CGFloat(M_PI) / 180, radius: radius - bigWidth)
            
            let smallPath = UIBezierPath(arcCenter: smallCenter, radius: smallWidth, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: false)
            smallShine.path = smallPath.cgPath
            addSublayer(smallShine)
            smallShineLayers.append(smallShine)
        }
    }
}


extension ShineAngleLayer: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    
        guard flag else {
            return
        }
        
        displayLink?.invalidate()
        displayLink = nil
        
        removeAllAnimations()
        removeFromSuperlayer()
    }
}
