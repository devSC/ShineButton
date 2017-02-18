//
//  ViewController.swift
//  ShineButton
//
//  Created by Wilson-Yuan on 2017/2/18.
//  Copyright © 2017年 Being Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var param1 = ShineParams()
        param1.bigShineColor = UIColor(rgb: (153,152,38))
        param1.smallShineColor = UIColor(rgb: (102,102,102))
        let bt1 = ShineButton(frame: .init(x: 100, y: 100, width: 60, height: 60), params: param1)
        bt1.fillColor = UIColor(rgb: (153,152,38))
        bt1.color = UIColor(rgb: (170,170,170))
        bt1.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(bt1)
        
        var param2 = ShineParams()
        param2.bigShineColor = UIColor(rgb: (255,95,89))
        param2.smallShineColor = UIColor(rgb: (216,152,148))
        param2.shineCount = 15
        param2.smallShineOffsetAngle = -5
        let bt2 = ShineButton(frame: .init(x: 200, y: 100, width: 60, height: 60), params: param2)
        bt2.fillColor = UIColor(rgb: (255,95,89))
        bt2.color = UIColor(rgb: (170,170,170))
        bt2.image = .like
        bt2.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(bt2)
        
        var param3 = ShineParams()
        param3.allowRandomColor = true
        let bt3 = ShineButton(frame: .init(x: 300, y: 100, width: 60, height: 60), params: param3)
        bt3.fillColor = UIColor(rgb: (255,41,1))
        bt3.color = UIColor(rgb: (170,170,170))
        bt3.image = .smile
        bt3.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(bt3)
        
        var param4 = ShineParams()
        param4.enableFlashing = true
        let bt4 = ShineButton(frame: .init(x: 400, y: 100, width: 60, height: 60), params: param4)
        bt4.fillColor = UIColor(rgb: (167,99,154))
        bt4.color = UIColor(rgb: (170,170,170))
        bt4.image = .star
        bt4.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(bt4)

    }

    @objc private func action() {
        print("点击")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

