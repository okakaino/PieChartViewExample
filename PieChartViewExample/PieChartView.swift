//
//  PieChartView.swift
//  PieChartViewExample
//
//  Created by Ted Gao on 2017-06-14.
//  Copyright © 2017 Ted Gao. All rights reserved.
//

import UIKit

class PieChartView: UIView
{
    enum PieChartType
    {
        case SolidCenter, HollowCenter
    }

    var pieChartType = PieChartType.SolidCenter
    {
        didSet
        {
            setNeedsDisplay()
        }
    }
    
    var eventCount: Int = 0
    {
        didSet
        {
            eventCount = eventCount < 0 ? 0 : eventCount
            
            setNeedsDisplay()
        }
    }
    
    private var diameterToViewWidthRatio: CGFloat = 0.8
    {
        didSet
        {
            setNeedsDisplay()
        }
    }
    
    private var holeRadiusToCircleRadiusRatio: CGFloat = 0.8
    {
        didSet
        {
            setNeedsDisplay()
        }
    }  
    private var labelBackgroundColor = UIColor.magenta
    {
        didSet
        {
            setNeedsDisplay()
        }
    }
    
    private var chartColors = [UIColor]()
    
    private var randomColor: UIColor {
        let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    func changeLabelColor(toColor: UIColor? = nil)
    {
        labelBackgroundColor = toColor ?? randomColor
    }
    
    override func draw(_ rect: CGRect)
    {
        // some idea from Hamish's answer: https://stackoverflow.com/a/35802580
        // get current context
        let ctx = UIGraphicsGetCurrentContext()
        
        // radius is the half the frame's width or height (whichever is smallest)
        let radius = min(frame.size.width, frame.size.height) * diameterToViewWidthRatio / 2
        
        // center of the view
        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        
        // the starting angle is -90 degrees (top of the circle, as the context is flipped). By default, 0 is the right hand side of the circle, with the positive angle being in an anti-clockwise direction (same as a unit circle in maths).
        var startAngle = -CGFloat.pi * 0.5
        
        if eventCount > 0
        {
            for count in 0..<eventCount
            {
                if count >= chartColors.count
                {
                    chartColors.append(randomColor)
                }

                // update the end angle of the segment
                let angleIncrement = 2 * CGFloat.pi / CGFloat(eventCount)
                let endAngle = startAngle + angleIncrement
                
                switch pieChartType
                {
                    case .SolidCenter:
                        // to draw a circle with solid center
                        // set fill color to the segment color
                        ctx?.setFillColor(chartColors[count].cgColor)
                        
                        // move to the center of the pie chart
                        ctx?.move(to: viewCenter)
                        
                        // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
                        ctx?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                        
                        // fill segment
                        ctx?.fillPath()
                        
                    case .HollowCenter:
                        // to draw a circle with a hole in the center
                        let outerArc = UIBezierPath(arcCenter: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                        outerArc.addArc(withCenter: viewCenter, radius: radius * 0.8, startAngle: endAngle, endAngle: startAngle, clockwise: false)
                        
                        outerArc.close()
                        
                        chartColors[count].setFill()
                        
                        outerArc.fill()
                }
                
                // update starting angle of the next segment to the ending angle of this segment
                startAngle = endAngle
            }
        }
        
        ctx?.setFillColor(labelBackgroundColor.cgColor)
        ctx?.move(to: viewCenter)
        ctx?.addArc(center: viewCenter, radius: radius * holeRadiusToCircleRadiusRatio, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        ctx?.fillPath()
    }
}
