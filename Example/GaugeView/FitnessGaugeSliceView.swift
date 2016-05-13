//
//  FitnessGaugeSliceView.swift
//  GaugeView
//
//  Created by Lisardo Kist on 5/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import GaugeView

@IBDesignable public class FitnessGaugeSliceView: UIView {
    
    var gaugeView: GaugeView!
    var startLine: CAShapeLayer = CAShapeLayer()
    var finishLine: CAShapeLayer = CAShapeLayer()

    @IBInspectable public var startAngle: Float = 0.0
    @IBInspectable public var percentage: Float = 0.0 {
        didSet {
            if let gaugeView = gaugeView {
                gaugeView.percentage = percentage
            }
        }
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        drawAnchorLines()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        drawAnchorLines()
        setupGaugeView()
    }
    
//    func drawAnchorLine() {
//        
//        let path = UIBezierPath()
//        
//        let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
//        
//        let length: Float = Float(self.frame.width)/2.0
//        
//        var deltax = CGFloat(cos(self.startAngle.degreesToRadians)*100.0)
//        var deltay = CGFloat(sin(self.startAngle.degreesToRadians)*100.0)
//        let p1 = CGPointMake(center.x + deltax, center.y + deltay)
//        
//        deltax = CGFloat(cos(self.startAngle.degreesToRadians)*length )
//        deltay = CGFloat(sin(self.startAngle.degreesToRadians)*length )
//        let p2 = CGPointMake(center.x + deltax, center.y + deltay)
//        
//        path.moveToPoint(p1)
//        path.addLineToPoint(p2)
//        
//        line = CAShapeLayer()
//        line.path = path.CGPath
//        line.strokeColor = UIColor.grayColor().CGColor
//        line.lineWidth = 1.5
//        line.fillColor = UIColor.clearColor().CGColor
//        
//        self.layer.addSublayer(line)
//        
//    }
    
    func drawAnchorLines() {
        drawLine(startAngle, line: startLine)
        drawLine(startAngle + 60.0, line: finishLine)
    }
    
    func drawLine(angle: Float, line: CAShapeLayer) {
        let path = UIBezierPath()
        
        let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        
        let length: Float = Float(self.frame.width)/2.0
        
        var deltax = CGFloat(cos(angle.degreesToRadians)*100.0)
        var deltay = CGFloat(sin(angle.degreesToRadians)*100.0)
        let p1 = CGPointMake(center.x + deltax, center.y + deltay)
        
        deltax = CGFloat(cos(angle.degreesToRadians)*length )
        deltay = CGFloat(sin(angle.degreesToRadians)*length )
        let p2 = CGPointMake(center.x + deltax, center.y + deltay)
        
        path.moveToPoint(p1)
        path.addLineToPoint(p2)
        
        line.path = path.CGPath
        line.strokeColor = UIColor.grayColor().CGColor
        line.lineWidth = 1.5
        line.fillColor = UIColor.clearColor().CGColor
        
        self.layer.addSublayer(line)
    }
    
    func setupGaugeView() {
        gaugeView = GaugeView(frame: self.frame)
        gaugeView.thickness = 12.0
        gaugeView.gaugeBackgroundColor = UIColor.clearColor()
        gaugeView.gaugeColor = UIColor.darkGrayColor()
        gaugeView.startAngle = self.startAngle
        gaugeView.percentage = percentage
        gaugeView.sizeToFit()
        self.addSubview(gaugeView!)
    }
    
    func setupFitnessParams(param: Float) {
        guard gaugeView != nil else {
            return
        }
        
        let mininumGray = CGFloat(0.25)
        let percentage = CGFloat(param/17.0)
        let grayPercentage = CGFloat(1.0 - (percentage*0.5 + mininumGray))
        
        gaugeView.gaugeColor = UIColor(red: grayPercentage, green: grayPercentage, blue: grayPercentage+0.01, alpha: 1.0)
        gaugeView.setNeedsDisplay()
        gaugeView.percentage = param
    }
    
    func pointBelongsTo(point: CGPoint) -> Bool {
        let startAngle = CGFloat(self.startAngle.degreesToRadians)
        let endAngle = CGFloat((self.startAngle + 60.0).degreesToRadians)
        let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        let normalizedPoint = CGPointMake(point.x - center.x , point.y - center.y )
        var pointAngle = -atan2(normalizedPoint.x, normalizedPoint.y)+CGFloat(M_PI_2)

        if (pointAngle < 0) {
            pointAngle += CGFloat(M_PI*2.0)
        }
        print(endAngle)
        print(startAngle)
        print(pointAngle)
        
        return (startAngle < pointAngle) && (endAngle > pointAngle)
    }
    
    func didSelect() {
        startLine.strokeColor = UIColor.redColor().CGColor
        finishLine.strokeColor = UIColor.redColor().CGColor
        superview?.bringSubviewToFront(self)
        self.gaugeView.gaugeColor = UIColor.redColor()
        self.gaugeView.setNeedsDisplay()
        self.gaugeView.percentage += 0.001
    }
    
    func didUnselect() {
        startLine.strokeColor = UIColor.grayColor().CGColor
        finishLine.strokeColor = UIColor.grayColor().CGColor
        self.gaugeView.gaugeColor = UIColor.grayColor()
        self.gaugeView.setNeedsDisplay()
        self.gaugeView.percentage -= 0.001
    }
}

extension Float {
    var doubleValue:      Double { return Double(self) }
    var degreesToRadians: Float  { return Float(doubleValue * M_PI / 180) }
    
}
