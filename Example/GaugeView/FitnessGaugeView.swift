import UIKit
import GaugeView

@IBDesignable
class FitnessGaugeView: UIView {
    
    @IBOutlet weak var gaugeView1: GaugeView!
    @IBOutlet weak var gaugeView2: GaugeView!
    @IBOutlet weak var gaugeView3: GaugeView!
    @IBOutlet weak var gaugeView4: GaugeView!
    @IBOutlet weak var gaugeView5: GaugeView!
    @IBOutlet weak var gaugeView6: GaugeView!
    
    @IBOutlet weak var trackTimeButton: UIButton!
    
    var flag = false
    
    @IBAction func didSelect(sender: UIButton) {
        let color = flag ? UIColor.lightGrayColor(): UIColor.redColor()
        flag = !flag
        if sender == trackTimeButton {
            self.gaugeView5.gaugeColor = color
            self.gaugeView5.setNeedsDisplay()
            self.gaugeView5.percentage += 0.01
        }
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
        setupFitnessMetrics(viewFromNib)
        return viewFromNib
        
    }
    
    private func setupFitnessMetrics(view: FitnessGaugeView) {
        for gauge in view.gauges() {
            let randomValue = arc4random_uniform(17)
            let maxGray = CGFloat(0.75)
            let mininumGray = CGFloat(0.25)
            let percentage = CGFloat(Float(randomValue)/17.0)
            let grayPercentage = CGFloat(1.0 - (percentage * 0.5+mininumGray))
            
            
            gauge.gaugeColor = UIColor(red: grayPercentage, green: grayPercentage, blue: grayPercentage+0.01, alpha: 1.0)
            gauge.setNeedsDisplay()
            gauge.percentage = Float(randomValue)
        }
    }
    
    func setupFitnessMetrics() {
        setupFitnessMetrics(self)
    }
    
    func gauges() -> [GaugeView] {
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