//
//  FBAnimationView.swift
//
//
//  Created by Yash Thaker on 17/05/18.
//  Copyright © 2018 Yash Thaker. All rights reserved.
//

import UIKit

class FBAnimationView: UIView {
    
    enum PathType {
        case one
        case two
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        _ = customPath(type: .one)
        _ = customPath(type: .two)
    }
    
    func animate(icon: UIImage) {
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            imageView.isHidden = true
            imageView.removeFromSuperview()
        })
        
        let randomPath = drand48() > 0.5 ? customPath(type: .one) : customPath(type: .two)
        
        let randomDuration: TimeInterval = drand48() > 0.5 ? 4 : 6
        
        let positionAnim = positionAnimation(randomDuration - 1, path: randomPath)
        let scaleAnim = scaleAnimation(randomDuration)
        let opacityAnim = opacityAnimation(randomDuration)
        let groupAnim = groupAnimation(randomDuration, animations: [positionAnim, scaleAnim, opacityAnim])
        
        imageView.layer.add(groupAnim, forKey: nil)
        CATransaction.commit()
        
        self.addSubview(imageView)
    }
    
    func positionAnimation(_ duration: TimeInterval, path: UIBezierPath) -> CAKeyframeAnimation {
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = duration
        positionAnimation.path = path.cgPath
        positionAnimation.fillMode = kCAFillModeForwards
        positionAnimation.isRemovedOnCompletion = true
        positionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        return positionAnimation
    }
    
    func scaleAnimation(_ duration: TimeInterval) -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0
        scaleAnimation.isRemovedOnCompletion = true
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        return scaleAnimation
    }
    
    func opacityAnimation(_ duration: TimeInterval) -> CAKeyframeAnimation {
        let opacity = CAKeyframeAnimation(keyPath: "opacity")
        opacity.duration = duration
        opacity.keyTimes = [0.4, 0.8, 5]
        opacity.values = [1, 0.7, 0]
        opacity.isRemovedOnCompletion = false
        return opacity
    }
    
    func groupAnimation(_ duration: TimeInterval, animations: [CAAnimation]) -> CAAnimationGroup {
        let group = CAAnimationGroup()
        group.duration = duration
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        group.isRemovedOnCompletion = true
        group.animations = animations
        return group
    }
    
    func customPath(type: PathType) -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: self.bounds.maxX - 50, y: self.bounds.maxY))
        
        let xPosCp1 = type == .one ? self.bounds.maxX - 120 : self.bounds.maxX + 20
        let xPosCp2 = type == .one ? self.bounds.maxX + 20 : self.bounds.maxX - 120

        let endPoint = CGPoint(x: self.bounds.maxX - 50, y: 0)
        let cp1 = CGPoint(x: xPosCp1, y: (self.bounds.maxY*3)/4)
        let cp2 = CGPoint(x: xPosCp2, y: self.bounds.maxY/4)
        
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        
//        path.stroke()
//        path.lineWidth = 3
        
        return path
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

