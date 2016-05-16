import UIKit
import GaugeView

@IBDesignable public class FitnessGaugeSliceView: UIView {
    
    var startLine = CAShapeLayer()
    var finishLine = CAShapeLayer()
    var gaugeView = GaugeView()
    var imageView: UIImageView!
    var selected = false
    var metric: MetricEnum!
    
    @IBInspectable public var startAngle: Float = 0.0
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGaugeView()
        setupImage()
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setupGaugeView()
        setupImage()
    }
    
    func setupGaugeView() {
        gaugeView = GaugeView(frame: frame)
        addSubview(gaugeView)
    }
    
    private func setupImage() {
        imageView = UIImageView(image: UIImage(named: "heck"))
        addSubview(imageView)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        updateGauge()
        updateImage()
        drawAnchorLines()
        superview?.bringSubviewToFront(self)
    }
    
    func setupFitnessParams(param: Float) {
        gaugeView.percentage = param
        if !selected {
            setGaugeColor(progressColor())
        }
    }
    
    func contains(point: CGPoint) -> Bool {
        let startAngle = CGFloat(self.startAngle.degreesToRadians)
        let endAngle = CGFloat((self.startAngle + 60.0).degreesToRadians)
        let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        let normalizedPoint = CGPointMake(point.x - center.x , point.y - center.y )
        var pointAngle = -atan2(normalizedPoint.x, normalizedPoint.y)+CGFloat(M_PI_2)
        
        if (pointAngle < 0) {
            pointAngle += CGFloat(M_PI*2.0)
        }
        
        return (startAngle < pointAngle) && (endAngle > pointAngle)
    }
    
    func didSelect() {
        selected = true
        setDelimiterLinesStrokeColor(UIColor.redColor().CGColor)
        setGaugeColor(UIColor.redColor())
        superview?.bringSubviewToFront(self)
    }
    
    func didUnselect() {
        selected = false
        setDelimiterLinesStrokeColor(UIColor.grayColor().CGColor)
        setGaugeColor(progressColor())
    }
    
    private func updateGauge() {
        gaugeView.frame = frame
        gaugeView.thickness = 12.0
        gaugeView.gaugeBackgroundColor = UIColor.clearColor()
        gaugeView.startAngle = startAngle
    }
    
    private func updateImage() {
        imageView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        let angle = startAngle + 30.0
        
        let deltax = CGFloat(cos(angle.degreesToRadians)*130.0)
        let deltay = CGFloat(sin(angle.degreesToRadians)*130.0)
        
        imageView.center = CGPoint(x: center.x - deltax, y: center.y - deltay)
    }
    
    private func drawAnchorLines() {
        drawLine(startAngle, line: startLine)
        drawLine(startAngle + 60.0, line: finishLine)
    }
    
    private func drawLine(angle: Float, line: CAShapeLayer) {
        let path = UIBezierPath()
        
        let length: Float = Float(self.frame.width)/2.0
        
        var deltax = CGFloat(cos(angle.degreesToRadians)*100.0)
        var deltay = CGFloat(sin(angle.degreesToRadians)*100.0)
        let p1 = CGPointMake(frame.midX + deltax, frame.midY + deltay)
        
        deltax = CGFloat(cos(angle.degreesToRadians)*length )
        deltay = CGFloat(sin(angle.degreesToRadians)*length )
        let p2 = CGPointMake(frame.midX + deltax, frame.midY + deltay)
        
        path.moveToPoint(p1)
        path.addLineToPoint(p2)
        
        line.path = path.CGPath
        line.strokeColor = UIColor.grayColor().CGColor
        line.lineWidth = 1.5
        line.fillColor = UIColor.clearColor().CGColor
        
        self.layer.addSublayer(line)
    }
    
    private func progressColor() -> UIColor {
        let mininumGray = CGFloat(0.25)
        let percentage = CGFloat(gaugeView.percentage/17.0)
        print(percentage)
        let grayPercentage = CGFloat(1.0 - (percentage * 0.5 + mininumGray))
        return UIColor(red:grayPercentage, green:grayPercentage, blue:grayPercentage + 0.01, alpha: 1.0)
    }
    
    private func setDelimiterLinesStrokeColor(color: CGColor) {
        startLine.strokeColor = color
        finishLine.strokeColor = color
    }
    
    private func setGaugeColor(color: UIColor) {
        gaugeView.gaugeColor = color
        gaugeView.percentage += 0.001
        gaugeView.setNeedsDisplay()
    }
}

extension Float {
    var doubleValue: Double { return Double(self) }
    var degreesToRadians: Float { return Float(doubleValue * M_PI / 180) }
}
