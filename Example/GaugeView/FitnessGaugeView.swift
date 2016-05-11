import UIKit
import GaugeView

@IBDesignable
class FitnessGaugeView: UIView {
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