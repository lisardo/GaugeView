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
        drawAnchorLine()
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
        drawAnchorLine()
        
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
    
    func drawAnchorLine() {
        
        let path = UIBezierPath()
        
        let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)

        let length: Float = Float(self.frame.width)/2.0
        
        var deltax = CGFloat(cos(self.startAngle.degreesToRadians)*100.0)
        var deltay = CGFloat(sin(self.startAngle.degreesToRadians)*100.0)
        let p1 = CGPointMake(center.x + deltax, center.y + deltay)
        
        deltax = CGFloat(cos(self.startAngle.degreesToRadians)*length )
        deltay = CGFloat(sin(self.startAngle.degreesToRadians)*length )
        let p2 = CGPointMake(center.x + deltax, center.y + deltay)
        
        path.moveToPoint(p1)
        path.addLineToPoint(p2)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor.grayColor().CGColor
        shapeLayer.lineWidth = 1.5
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        
        self.layer.addSublayer(shapeLayer)
        
        
    }
}

extension Float {
    var doubleValue:      Double { return Double(self) }
    var degreesToRadians: Float  { return Float(doubleValue * M_PI / 180) }
    
}
