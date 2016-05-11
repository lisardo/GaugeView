//
//  ViewController.swift
//  GaugeView
//
//  Created by Luca D'Incà on 11/01/2015.
//  Copyright (c) 2015 Luca D'Incà. All rights reserved.
//

import UIKit
import GaugeView

class ViewController: UIViewController {
  
    @IBOutlet weak var fitnessGaugeView: FitnessGaugeView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Gauge View example
//    gaugeView.percentage = 80
//    gaugeView.thickness = 10
//    
//    gaugeView.labelFont = UIFont.systemFontOfSize(40, weight: UIFontWeightThin)
//    gaugeView.labelColor = UIColor.lightGrayColor()
//    gaugeView.gaugeBackgroundColor = UIColor.lightGrayColor()
//    gaugeView.labelText = "80%"
  }
  
  
  @IBAction func didPressOnButton(sender: AnyObject) {
    
    fitnessGaugeView.setupFitnessMetrics()
//    gaugeView.percentage = Float(randomValue)
//    gaugeView.labelText = "\(randomValue)%"
  }
}

