//
//  PieChartViewController.swift
//  PieChartViewExample
//
//  Created by Ted Gao on 2017-06-13.
//  Copyright © 2017 Ted Gao. All rights reserved.
//

import UIKit

class PieChartViewController: UIViewController
{
    @IBAction func startSpringAnimation(_ sender: UIButton)
    {
        pieChartView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.pieChartView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
    
    @IBAction func toggleType(_ sender: UIButton)
    {
        pieChartView.pieChartType = pieChartView.pieChartType == .HollowCenter ? .SolidCenter : .HollowCenter
    }
    
    @IBAction func changeColor(_ sender: UIButton)
    {
//        pieChartView.changeLabelColor(toColor: UIColor.blue.cgColor)
        pieChartView.changeLabelColor()
    }
    
    @IBAction func clearColor(_ sender: UIButton)
    {
        pieChartView.changeLabelColor(toColor: UIColor.clear)
    }
    
    @IBAction func increment(_ sender: UIButton)
    {
        pieChartView.eventCount += 1
        pieChartView.setNeedsDisplay()
    }
    
    @IBAction func decrement(_ sender: UIButton)
    {
        pieChartView.eventCount -= 1
        pieChartView.setNeedsDisplay()
    }
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad()
    {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "creek_big")!)
        
        pieChartView.eventCount = 4
    }
}
