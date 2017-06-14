//
//  ViewController.swift
//  DrawRect Test
//
//  Created by Ted Gao on 2/6/2017.
//  Copyright © 2017 Ted Gao. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let viewFrame = CGRect(x: 100, y: 100, width: 150, height: 150)
        let customView = CustomDrawnView(frame: viewFrame, eventCount: 3)
//        customView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
//        customView.eventCount = 3
//        customView.backgroundColor = UIColor.brown
        
//        customView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
        customView.setNeedsDisplay()
        view.addSubview(customView)
    }
}

