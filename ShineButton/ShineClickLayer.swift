//
//  ShineClickLayer.swift
//  ShineButton
//
//  Created by Wilson-Yuan on 2017/2/18.
//  Copyright © 2017年 Being Inc. All rights reserved.
//

import UIKit

class ShineClickLayer: CALayer {

    var color = UIColor.lightGray
    
    var fillColor = UIColor(rgb: (255, 102, 102))
    
    var image: ShineImage = .heart {
        
        didSet {
            maskLayer.contents = image.image()
        }
    }
    
    var animationDuration: Double = 0.5
    
    var maskLayer = CALayer()
    
    var clicked: Bool = false {
        
        didSet {
            if clicked {
                backgroundColor = fillColor.cgColor
            } else {
                backgroundColor = color.cgColor
            }
        }
    }
    
    
    func startAnimation() -> Void {
        
        let anim = CAKeyframeAnimation(keyPath: "transform.scale")
        anim.duration = animationDuration
        anim.values = [0.4, 1, 0.9, 1]
        anim.calculationMode = kCAAnimationCubic
        maskLayer.add(anim, forKey: "scale")
    }
    
    override func layoutSublayers() {
        
        maskLayer.frame = bounds
        if clicked {
            backgroundColor = fillColor.cgColor
        } else {
            backgroundColor = color.cgColor
        }
        
        maskLayer.contents = image.image()?.cgImage
    }
    
    override init() {
        super.init()
        mask = maskLayer
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        mask = maskLayer
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
