//
//  CircularProgressView.swift
//  KGProgress
//
//  Created by kerry
//

import UIKit

class CircularProgressView: UIView {
    
    var prop: Property?
    
    var gradientLayer = CALayer()
    
    private struct Animation {
        var rotationZ: CABasicAnimation {
            let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.duration = 0.8
            animation.repeatCount = HUGE
            animation.fromValue = NSNumber(value: 0.0)
            animation.toValue = NSNumber(value: 2 * Float(M_PI))
            
            return animation
        }
        
        init() {}
        
        func start(_ layer: CALayer) {
            layer.add(rotationZ, forKey: "rotate")
        }
        
        func stop(_ layer: CALayer) {
            layer.removeAllAnimations()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(viewDidEnterBackground(_:)),
                                               name: .UIApplicationDidEnterBackground,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(viewWillEnterForeground(_:)),
                                               name: .UIApplicationWillEnterForeground,
                                               object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func viewDidEnterBackground(_ notification: Notification?) {
        Animation().stop(gradientLayer)
    }
    
    @objc private func viewWillEnterForeground(_ notification: Notification?) {
        Animation().start(gradientLayer)
    }
    
    internal func initialize(frame: CGRect) {
        
        guard let prop = prop else {
            return
        }
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        
        // Base Circular
        if let baseLineWidth = prop.baseLineWidth, let baseArcColor = prop.baseArcColor {
            let circular: ArcView = ArcView(frame: rect, lineWidth: baseLineWidth)
            circular.color = baseArcColor
            circular.prop = prop
            addSubview(circular)
        }
        
        // Gradient Circular
        if ColorUtil.toRGBA(color: prop.startArcColor).a < 1.0 || ColorUtil.toRGBA(color: prop.endArcColor).a < 1.0 {
            // Clear Color
            let gradient: UIView = GradientArcWithClearColorView().draw(rect: rect, prop: prop)
            addSubview(gradient)
            
            gradientLayer = gradient.layer
            Animation().start(gradientLayer)
            
        } else {
            // Opaque Color
            let gradient: GradientArcView = GradientArcView(frame: rect)
            gradient.prop = prop
            addSubview(gradient)
            
            gradientLayer = gradient.layer
            Animation().start(gradientLayer)
        }
    }
}
