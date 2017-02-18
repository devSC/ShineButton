//
//  ShineBundle.swift
//  ShineButton
//
//  Created by Wilson-Yuan on 2017/2/18.
//  Copyright © 2017年 Being Inc. All rights reserved.
//

import UIKit

struct ShineBundle {
    
    static var defaultBundle: Bundle {
        return Bundle(for: ShineButton.self)
    }
    
    
    static var bundle: Bundle {
        
        let nilAbleBundle = Bundle(path: self.defaultBundle.path(forResource: "ShineButton", ofType: "bundle")!)
        
        guard let bundle = nilAbleBundle else {
            fatalError("bundle source not found")
        }
        
        return bundle
    }
    
    
    static func image(with imageName: String) -> UIImage? {
        
        let bundle = Bundle(path: self.bundle.bundlePath + "/resource")
        guard let path = bundle?.path(forResource: imageName, ofType: "png") else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
}
