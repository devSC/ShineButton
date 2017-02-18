//
//  UIColor+extension.swift
//  ShineButton
//
//  Created by Wilson-Yuan on 2017/2/18.
//  Copyright © 2017年 Being Inc. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: (r: CGFloat, g: CGFloat, b: CGFloat)) {
        self.init(red: rgb.r / 255.0, green: rgb.g / 255.0, blue: rgb.b / 255.0, alpha: 1)
    }
}
