//
//  Extension.swift
//  UTSpinnerView
//
//  Created by Sebarina Xu on 5/25/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import Foundation

let _mutableSpinnerViewKey = malloc(4)

public extension UIButton {

    public override func startLoading() {
        if spinnerView == nil {
            spinnerView = UTSpinnerView(frame: CGRectMake(0, 0, frame.width, frame.height))
            spinnerView?.spinPercentage = 0.45
            
            if currentBackgroundImage != nil {
                spinnerView?.backgroundImage = currentBackgroundImage
            } else if backgroundColor != nil {
                spinnerView?.backgroundColor = backgroundColor                
            } else {
                spinnerView?.backgroundColor = UIColor.clearColor()
                
            }
            spinnerView?.lineColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
            
            addSubview(spinnerView!)
        }
        spinnerView?.hidden = false
        spinnerView?.startAnimation()
        enabled = false
    }
    
    public override func endLoading() {
        spinnerView?.stopAnimation()
        spinnerView?.hidden = true
        enabled = true
        
    }
}

public extension UIView {
    private var spinnerView : UTSpinnerView? {
        get {
            let r : AnyObject! = objc_getAssociatedObject(self, _mutableSpinnerViewKey)
            return r as? UTSpinnerView
        }
        set {
            objc_setAssociatedObject(self, _mutableSpinnerViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public func startLoading(lineColor: UIColor) {
        let loadingRadius = min(min(frame.width, frame.height), 100)
        
        if spinnerView == nil {
            spinnerView = UTSpinnerView(frame: CGRectMake((frame.width - loadingRadius)/2, (frame.height - loadingRadius)/2, loadingRadius, loadingRadius))
            
            if backgroundColor != nil {
                spinnerView?.backgroundColor = backgroundColor                
            } else {
                spinnerView?.backgroundColor = UIColor.clearColor()
                
            }
            spinnerView?.lineColor = lineColor
            
            addSubview(spinnerView!)
        }
        spinnerView?.hidden = false
        spinnerView?.startAnimation()
        
    }
    
    
    public func startLoading() {
        let loadingRadius = min(min(frame.width, frame.height), 100)
        
        if spinnerView == nil {
            spinnerView = UTSpinnerView(frame: CGRectMake((frame.width - loadingRadius)/2, (frame.height - loadingRadius)/2, loadingRadius, loadingRadius))
            
            if backgroundColor != nil {
                spinnerView?.backgroundColor = backgroundColor                
            } else {
                spinnerView?.backgroundColor = UIColor.clearColor()
                
            }
            spinnerView?.lineColor = UIColor(red: 0xF3/255.0, green: 0x77/255.0, blue: 0x85/255.0, alpha: 1)
            spinnerView?.lineWidth = 5
            addSubview(spinnerView!)
        }
        spinnerView?.hidden = false
        spinnerView?.startAnimation()
    }
    
    public func endLoading() {
        spinnerView?.stopAnimation()
        spinnerView?.hidden = true
        
    }
}