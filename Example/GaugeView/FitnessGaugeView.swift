import UIKit
import GaugeView

@IBDesignable
class FitnessGaugeView: UIView {
    
    @IBOutlet weak var gaugeView1: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView2: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView3: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView4: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView5: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView6: FitnessGaugeSliceView!
    
    @IBOutlet weak var trackTimeButton: UIButton!
    
    var flag = false
    
    @IBAction func didSelect(sender: UIButton) {
    }
    
    override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
        if tag == 10 {
            return self
        }
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let viewFromNib = bundle.loadNibNamed("FitnessGaugeView", owner: nil, options: nil)[0] as! FitnessGaugeView
        viewFromNib.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        viewFromNib.autoresizingMask = autoresizingMask
        cloneConstraints(viewFromNib)
        return viewFromNib
        
    }
    
    private func setupFitnessMetrics(view: FitnessGaugeView) {
        for metricDisplay in view.metrics() {
            let randomValue = arc4random_uniform(17)
            metricDisplay.setupFitnessParams(Float(randomValue))
        }
    }
    
    func setupFitnessMetrics() {
        setupFitnessMetrics(self)
    }

    func metrics() -> [FitnessGaugeSliceView] {
        return [gaugeView1, gaugeView2, gaugeView3, gaugeView4, gaugeView5, gaugeView6]
    }
}


extension UIView {
    func cloneConstraints(toView: UIView) {
        for constraint in constraints {
            var firstItem = constraint.firstItem as! UIView
            if firstItem == self {
                firstItem = toView
            }
            var secondItem = constraint.secondItem as? UIView
            if secondItem == self {
                secondItem = toView
            }
            let constraint = NSLayoutConstraint(item: firstItem, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant)
            toView.addConstraint(constraint)
        }
    }
}