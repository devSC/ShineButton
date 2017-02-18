//
//  ShineButton.swift
//  ShineButton
//
//  Created by Wilson-Yuan on 2017/2/18.
//  Copyright © 2017年 Being Inc. All rights reserved.
//

import UIKit

class ShineButton: UIControl {
    
    //more config params
    var params: ShineParams {
        didSet {
            clickLayer.animationDuration = params.animDuration / 3
            shineLayer.params = params
        }
    }
    
    ///default color
    var color = UIColor.lightGray {
        willSet {
            clickLayer.color = newValue
        }
    }
    
    // click color
    var fillColor = UIColor(rgb: (255, 102, 102)) {
        willSet {
            clickLayer.fillColor = newValue
            shineLayer.fillColor = newValue
        }
    }
    
    var image: ShineImage = .heart {
        willSet {
            clickLayer.image = newValue
        }
    }
    
    
    
    private var clickLayer = ShineClickLayer()
    
    private var shineLayer = ShineLayer()
    
    init(frame: CGRect, params: ShineParams) {
        self.params = params
        super.init(frame: frame)
        initLayers()
    }
    
    override init(frame: CGRect) {
        params = ShineParams()
        super.init(frame: frame)
        initLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        params = ShineParams()
        super.init(coder: aDecoder)
        
        layoutIfNeeded()
        initLayers()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if clickLayer.clicked == false {
            
            shineLayer.endAnim = { [weak self] in
                
                guard let `self` = self else { return }
                self.clickLayer.clicked = !self.clickLayer.clicked
                self.clickLayer.startAnimation()
            }
            shineLayer.startAnimation()
        } else {
            clickLayer.clicked = !clickLayer.clicked
        }
    }
    
    private func initLayers() -> Void {
        clickLayer.animationDuration = params.animDuration / 3
        shineLayer.params = params
        clickLayer.frame = bounds
        shineLayer.frame = bounds
        layer.addSublayer(clickLayer)
        layer.addSublayer(shineLayer)
    }
}
