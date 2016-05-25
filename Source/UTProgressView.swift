//
//  UTProgressView.swift
//  UTSpinnerView
//
//  Created by Sebarina Xu on 5/25/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit

public class UTProgressView: UIView {
    public var startAngle : Double = 0
    
    public var fontColor : UIColor =  UIColor.blackColor(){
        didSet {
            textLabel?.textColor = fontColor
        }
    }
    
    public var fontSize : CGFloat = 12 {
        didSet {
            textLabel?.font = UIFont.systemFontOfSize(fontSize)
        }
    }
    
    public var progressLineWidth : CGFloat =  2
    
    public var progressColor : UIColor = UIColor.blueColor()
    public var emptyColor : UIColor = UIColor.whiteColor()
    
    public var percentText : String {
        get {
            return textLabel?.text ?? ""
        }
        set {
            textLabel?.text = newValue
        }
    }
    
    public var progress : Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var textLabel : UILabel?
    
    public init(frame:CGRect, startAngle: Double, progressWidth: CGFloat, emptyColor: UIColor, progressColor: UIColor) {
        super.init(frame: frame)
        self.startAngle = startAngle
        self.progressLineWidth = progressWidth
        self.progressColor = progressColor
        self.emptyColor = emptyColor
        initView()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func initView() {
        backgroundColor = UIColor.clearColor()
        
        textLabel = UILabel(frame: CGRectMake(progressLineWidth, 0, frame.width - progressLineWidth*2, frame.height))
        textLabel?.backgroundColor = UIColor.clearColor()
        textLabel?.textAlignment = .Center
        addSubview(textLabel!)
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let start : CGFloat = CGFloat(startAngle*M_PI/180.0)
        let end : CGFloat = start + CGFloat(progress*2*M_PI)
        let radius : CGFloat = min(rect.height, rect.width)/2 - progressLineWidth/2
        
        // 空白弧线
        let emptyPath : UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: end, endAngle: CGFloat(2*M_PI) + start, clockwise: true)
        emptyPath.lineWidth = progressLineWidth
        emptyColor.setStroke()
        emptyPath.stroke()
        
        // 进度弧线
        let progressPath : UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: start, endAngle: end, clockwise: true)
        progressPath.lineWidth = progressLineWidth
        progressPath.lineCapStyle = CGLineCap.Round
        progressColor.setStroke()
        progressPath.stroke()
        
        
    }
    
    
}
