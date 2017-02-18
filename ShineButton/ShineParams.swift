//
//  ShineParams.swift
//  ShineButton
//
//  Created by Wilson-Yuan on 2017/2/18.
//  Copyright © 2017年 Being Inc. All rights reserved.
//

import UIKit

struct ShineParams {
    /// shine是否随机颜色
    public var allowRandomColor: Bool       = false
    /// shine动画时间，秒
    public var animDuration: Double         = 1
    /// 大Shine的颜色
    public var bigShineColor: UIColor       = UIColor(rgb: (255, 102, 102))
    /// 是否需要Flash效果
    public var enableFlashing: Bool         = false
    /// shine的个数
    public var shineCount: Int              = 7
    /// shine的扩散的旋转角度
    public var shineTurnAngle: Float        = 20
    /// shine的扩散的范围的倍数
    public var shineDistanceMultiple: Float = 1.5
    /// 小shine与大shine之前的角度差异
    public var smallShineOffsetAngle: Float = 20
    /// 小shine的颜色
    public var smallShineColor: UIColor     = UIColor.lightGray
    /// shine的大小
    public var shineSize: CGFloat = 0
    /// 随机的颜色列表
    public var colorRandom: [UIColor]       = [UIColor(rgb: (255, 255, 153)),
                                               UIColor(rgb: (255, 204, 204)),
                                               UIColor(rgb: (153, 102, 153)),
                                               UIColor(rgb: (255, 102, 102)),
                                               UIColor(rgb: (255, 255, 102)),
                                               UIColor(rgb: (244, 67, 54)),
                                               UIColor(rgb: (102, 102, 102)),
                                               UIColor(rgb: (204, 204, 0)),
                                               UIColor(rgb: (102, 102, 102)),
                                               UIColor(rgb: (153, 153, 51))]
    public init() {}

}


enum ShineImage: String {
    
    case heart 
    case like
    case smile
    case star
    case custom
    
    func image() -> UIImage? {
        return ShineBundle.image(with: self.rawValue)
    }
}


