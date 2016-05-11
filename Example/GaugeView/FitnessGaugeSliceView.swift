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
//        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()   
//        setup()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        print(self.frame)
        print(self.bounds)
        gaugeView = GaugeView(frame: self.frame)
        gaugeView.thickness = 12.0
        gaugeView.gaugeBackgroundColor = UIColor.clearColor()
        gaugeView.gaugeColor = UIColor.darkGrayColor()
        gaugeView.startAngle = self.startAngle
        gaugeView.percentage = percentage
        
        
        self.addSubview(gaugeView!)
        gaugeView.sizeToFit()
    }
    
}
