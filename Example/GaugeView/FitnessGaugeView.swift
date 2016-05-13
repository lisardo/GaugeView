import UIKit
import GaugeView

@IBDesignable
class FitnessGaugeView: UIView, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var gaugeView1: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView2: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView3: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView4: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView5: FitnessGaugeSliceView!
    @IBOutlet weak var gaugeView6: FitnessGaugeSliceView!
    
    @IBOutlet weak var centerValue: UILabel!
    @IBOutlet weak var centerTitle: UILabel!
    
    var flag = false
    weak var delegate: FitnessGaugeDelegate?
    
    override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
        if tag == 10 {
            return self
        }
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let viewFromNib = bundle.loadNibNamed("FitnessGaugeView", owner: nil, options: nil)[0] as! FitnessGaugeView
        viewFromNib.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        viewFromNib.autoresizingMask = autoresizingMask
        cloneConstraints(viewFromNib)
        setup(viewFromNib)
        setupMetrics(viewFromNib)
        return viewFromNib
        
    }

    
    func setup(view: FitnessGaugeView) {
        let tap = UITapGestureRecognizer(target: view, action: #selector(FitnessGaugeView.handleTap(_:)))
        tap.delegate = view
        view.addGestureRecognizer(tap)
    }
    
    func setupMetrics(view: FitnessGaugeView) {
        view.gaugeView1.metric = MetricEnum.BodyMass
        view.gaugeView2.metric = MetricEnum.CGBold
        view.gaugeView3.metric = MetricEnum.CheckIns
        view.gaugeView4.metric = MetricEnum.Strenght
        view.gaugeView5.metric = MetricEnum.Time
        view.gaugeView6.metric = MetricEnum.Weight
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        let point = sender?.locationInView(self)
        for gauge in self.metrics() {
            if (gauge.pointBelongsTo(point!)) {
                delegate?.didSelectMetric(gauge.metric)
                gauge.didSelect()
                centerTitle.text = gauge.metric.rawValue
                centerValue.text = "\(gauge.gaugeView.percentage)"
            } else {
                gauge.didUnselect()
            }
        }
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

protocol FitnessGaugeDelegate: class {
    func didSelectMetric(metric: MetricEnum)
}