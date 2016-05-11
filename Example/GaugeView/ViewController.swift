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
  }
  
  
  @IBAction func didPressOnButton(sender: AnyObject) {
    fitnessGaugeView.setupFitnessMetrics()
  }
}

