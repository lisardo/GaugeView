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
    
    @IBOutlet var gaugeViews: [FitnessGaugeSliceView]!
    
    @IBOutlet weak var centerValue: UILabel!
    @IBOutlet weak var centerTitle: UILabel!
    
    weak var delegate: FitnessGaugeDelegate?
    weak var dataSource: FitnessGaugeDataSource? {
        didSet {
            setupFitnessMetrics()
        }
    }
    
    override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
        if tag == 10 {
            return self
        }
    
        let viewFromNib = NSBundle(forClass: self.dynamicType).loadNibNamed("FitnessGaugeView", owner: nil, options: nil)[0] as! FitnessGaugeView
        viewFromNib.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        viewFromNib.autoresizingMask = autoresizingMask
        cloneConstraints(viewFromNib)
        setupTapGesture(viewFromNib)
        setupMetricViews(viewFromNib)
        return viewFromNib
    }

    
    func setupTapGesture(view: FitnessGaugeView) {
        let tap = UITapGestureRecognizer(target: view, action: #selector(FitnessGaugeView.handleTap(_:)))
        tap.delegate = view
        view.addGestureRecognizer(tap)
    }
    
    func setupMetricViews(view: FitnessGaugeView) {
        view.gaugeView1.metric = MetricEnum.BodyMass
        view.gaugeView2.metric = MetricEnum.CGBold
        view.gaugeView3.metric = MetricEnum.CheckIns
        view.gaugeView4.metric = MetricEnum.Strenght
        view.gaugeView5.metric = MetricEnum.Time
        view.gaugeView6.metric = MetricEnum.Weight
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        let point = sender?.locationInView(self)
        for metricView in gaugeViews {
            if (metricView.pointBelongsTo(point!)) {
                delegate?.fitnessGaugeDidSelectMetric(metricView.metric)
                metricView.didSelect()
                centerTitle.text = metricView.metric.rawValue
                centerValue.text = "\(metricView.gaugeView!.percentage)"
            } else {
                metricView.didUnselect()
            }
        }
    }
    
    func setupFitnessMetrics() {
        gaugeViews.forEach { (view) in
            view.setupFitnessParams(Float(arc4random_uniform(17)))
        }
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
    func fitnessGaugeDidSelectMetric(metric: MetricEnum)
}

protocol FitnessGaugeDataSource: class {
    func fitnessGaugeValueForSection(metric: MetricEnum) -> Float
}