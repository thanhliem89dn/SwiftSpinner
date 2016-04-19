//
//  OvalLayer.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-19.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit

struct Colors {
    static let blue = UIColor(red: 46.0 / 255.0, green: 117.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
    static let red = UIColor(red: 209.0 / 255.0, green: 42.0 / 255.0, blue: 24.0 / 255.0, alpha: 1.0)
    static let white = UIColor.whiteColor()
    static let clear = UIColor.clearColor()
}

class OvalLayer: CAShapeLayer {
    
    let animationDuration: CFTimeInterval = 0.3
    
    init(frame: CGRect) {
        super.init()
        self.frame = frame
        fillColor = UIColor.orangeColor().CGColor
        path = ovalPathSmall.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var ovalPathSmall: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: self.frame.width/2, y: self.frame.height/2, width: 0.0, height: 0.0))
    }
    
    var ovalPathLarge: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    }
    
    var ovalPathSquishVertical: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 0, y: 2.5, width: self.frame.width, height: self.frame.height - 5.0))
    }
    
    var ovalPathSquishHorizontal: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 0, width: self.frame.width - 5.0, height: self.frame.height - 5.0))
    }
    
    func expand() {
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = ovalPathSmall.CGPath
        expandAnimation.toValue = ovalPathLarge.CGPath
        expandAnimation.duration = animationDuration
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.removedOnCompletion = false
        addAnimation(expandAnimation, forKey: nil)
    }
    
    func wobble(delegate: AnyObject) {
        // 1
        let wobbleAnimation1: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation1.fromValue = ovalPathLarge.CGPath
        wobbleAnimation1.toValue = ovalPathSquishVertical.CGPath
        wobbleAnimation1.beginTime = 0.0
        wobbleAnimation1.duration = animationDuration
        
        // 2
        let wobbleAnimation2: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation2.fromValue = ovalPathSquishVertical.CGPath
        wobbleAnimation2.toValue = ovalPathSquishHorizontal.CGPath
        wobbleAnimation2.beginTime = wobbleAnimation1.beginTime + wobbleAnimation1.duration
        wobbleAnimation2.duration = animationDuration
        
        // 3
        let wobbleAnimation3: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation3.fromValue = ovalPathSquishHorizontal.CGPath
        wobbleAnimation3.toValue = ovalPathSquishVertical.CGPath
        wobbleAnimation3.beginTime = wobbleAnimation2.beginTime + wobbleAnimation2.duration
        wobbleAnimation3.duration = animationDuration
        
        // 4
        let wobbleAnimation4: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation4.fromValue = ovalPathSquishVertical.CGPath
        wobbleAnimation4.toValue = ovalPathLarge.CGPath
        wobbleAnimation4.beginTime = wobbleAnimation3.beginTime + wobbleAnimation3.duration
        wobbleAnimation4.duration = animationDuration
        
        // 5
        let wobbleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        wobbleAnimationGroup.delegate = delegate
        wobbleAnimationGroup.animations = [wobbleAnimation1, wobbleAnimation2, wobbleAnimation3,
                                           wobbleAnimation4]
        wobbleAnimationGroup.duration = wobbleAnimation4.beginTime + wobbleAnimation4.duration
        wobbleAnimationGroup.repeatCount = 2
        addAnimation(wobbleAnimationGroup, forKey: nil)
        
    }
    
    func contract() {
        
    }
}
