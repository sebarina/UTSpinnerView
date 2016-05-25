//
//  SpinnerView.swift
//  UTSpinnerView
//
//  Created by Sebarina Xu on 5/25/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit

public class UTSpinnerView: UIView {

    override public var layer: CAShapeLayer {
        get {
            return super.layer as! CAShapeLayer
        }
    }
    
    override public class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    public var lineWidth : CGFloat = 3
    public var lineColor : UIColor = UIColor.blackColor() {
        didSet {
            layer.strokeColor = lineColor.CGColor
        }
    }
    public var spinPercentage : CGFloat = 0.8
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    public init(frame: CGRect, lineWidth: CGFloat, lineColor: UIColor, spinPercentage: CGFloat) {
        super.init(frame: frame)
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.spinPercentage = spinPercentage
        initView()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initView() {
        layer.fillColor = nil
        layer.lineWidth = 0
        
    }
    
    
    public var backgroundImage : UIImage? {
        didSet {
            if backgroundImage != nil {
                backgroundColor = UIColor(patternImage: backgroundImage!)
            }
        }
    }
    
    public func startAnimation() {
        setPath()
        layer.lineWidth = lineWidth
        animate()
    }
    
    public func stopAnimation() {
        layer.lineWidth = 0
        layer.removeAllAnimations()
    }
    
    private func setPath() {
        let radius : CGFloat = spinPercentage*min(bounds.height, bounds.width)
        let rect = CGRectMake((bounds.width - radius)/2, (bounds.height - radius)/2, radius, radius)
        layer.path = UIBezierPath(ovalInRect: CGRectInset(rect, layer.lineWidth / 2, layer.lineWidth / 2)).CGPath
    }
    
    struct Pose {
        let secondsSincePriorPose: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsSincePriorPose = secondsSincePriorPose
            self.start = start
            self.length = length
        }
    }
    
    class var poses: [Pose] {
        get {
            return [
                Pose(0.0, 0.000, 0.08),
                Pose(0.1, 0.020, 0.18),
                Pose(0.1, 0.040, 0.28),
                Pose(0.1, 0.060, 0.38),
                Pose(0.1, 0.080, 0.48),
                Pose(0.1, 0.100, 0.58),
                Pose(0.1, 0.120, 0.68),
                Pose(0.1, 0.140, 0.78),
                Pose(0.1, 0.160, 0.88),
                Pose(0.1, 0.180, 0.98),
                Pose(0.1, 0.200, 1.0),
                
                
            ]
        }
    }
    
    func animate() {
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()
        
        let totalSeconds = self.dynamicType.poses.reduce(0) { $0 + $1.secondsSincePriorPose }
        
        for pose in self.dynamicType.poses {
            time += pose.secondsSincePriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start)
            strokeEnds.append(pose.length)
        }
        
        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])
        
        animateKeyPath("strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
        animateKeyPath("strokeStart", duration: totalSeconds, times: times, values: rotations)
        
    }
    
    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times
        animation.values = values
        animation.calculationMode = kCAAnimationLinear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.addAnimation(animation, forKey: animation.keyPath)
    }

}
