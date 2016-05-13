//
//  ViewController.swift
//  GaugeView
//
//  Created by Luca D'Incà on 11/01/2015.
//  Copyright (c) 2015 Luca D'Incà. All rights reserved.
//

import UIKit
import GaugeView

class ViewController: UIViewController, FitnessGaugeDelegate, FitnessGaugeDataSource {
    
    @IBOutlet weak var fitnessGaugeView: FitnessGaugeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fitnessGaugeView.delegate = self
        fitnessGaugeView.dataSource = self
        
    }
    
    func fitnessGaugeDidSelectMetric(metric: MetricEnum) {
        print("metric selected: \(metric)")
    }
    
    func fitnessGaugeValueForSection(metric: MetricEnum) -> Float {
        return 10
    }
    
    @IBAction func didPressOnButton(sender: AnyObject) {
        fitnessGaugeView.setupFitnessMetrics()
    }
}

