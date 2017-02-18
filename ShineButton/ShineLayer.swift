//
//  ShineLayer.swift
//  ShineButton
//
//  Created by Wilson-Yuan on 2017/2/18.
//  Copyright © 2017年 Being Inc. All rights reserved.
//

import UIKit

class ShineLayer: CALayer {
    
    let shapeLayer = CAShapeLayer()
    
    var fillColor = UIColor(rgb: (255, 102, 102)) {
        willSet {
            shapeLayer.strokeColor = newValue.cgColor
        }
    }
    
    var params = ShineParams()
    
    var displayLink: CADisplayLink?
    
    var endAnim: (()->Void)?
    
    //MARK: Public method
    func startAnimation() -> Void {
        
        let anim = CAKeyframeAnimation(keyPath: "path")
        anim.duration = params.animDuration * 0.1
        
        let size = frame.size
        let fromPath = UIBezierPath(arcCenter: CGPoint(x: size.width / 2, y: size.height / 2), radius: 1, startAngle: 0, endAngle: CGFloat(M_PI) * 2.0, clockwise: false).cgPath
        let toPath = UIBezierPath(arcCenter: CGPoint(x: size.width / 2, y: size.height / 2), radius: size.width / 2 * CGFloat(params.shineDistanceMultiple), startAngle: 0, endAngle: CGFloat(M_PI) * 2.0, clockwise: false).cgPath
        
        anim.delegate = self
        anim.values = [fromPath, toPath]
        anim.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
    
        shapeLayer.add(anim, forKey: "path")
        if params.enableFlashing {
            startFlash()
        }
    }
    
    
    override init() {
        super.init()
        initLayers()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initLayers() {
        
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = fillColor.cgColor
        shapeLayer.lineWidth = 1.5
        addSublayer(shapeLayer)
    }

    
    private func startFlash() {
        
        displayLink = CADisplayLink(target: self, selector: #selector(flashAction))
        
        if #available(iOS 10.0, *) {
            displayLink?.preferredFramesPerSecond = 6
        } else {
            displayLink?.frameInterval = 10
        }
        displayLink?.add(to: .current, forMode: .commonModes)
    }
    
    
    func flashAction() -> Void {
        let index = Int(arc4random()) % params.colorRandom.count
        shapeLayer.strokeColor = params.colorRandom[index].cgColor
    }
}

extension ShineLayer: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        guard flag else { return }
        
        displayLink?.invalidate()
        displayLink = nil
        shapeLayer.removeAllAnimations()
        
        let angleLayer = ShineAngleLayer(frame: bounds, params: params)
        addSublayer(angleLayer)
        angleLayer.startAnimation()
        
        endAnim?()
    }
}
