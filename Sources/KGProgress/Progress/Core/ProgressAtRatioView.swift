//
//  ProgressAtRatioView.swift
//  KGProgress
//
//  Created by kerry
//

import UIKit

class ProgressAtRatioView: UIView {
    
    internal var arcView: ArcView?
    internal var prop: Property?
    internal var ratioLabel: UILabel = UILabel()
    
    internal var ratio: CGFloat = 0.0 {
        didSet {
            ratioLabel.text = String(format:"%.0f", ratio * 100) + "%"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initialize(frame: CGRect) {
        
        guard let prop = prop else {
            return
        }
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        
        // Base Circular
        if let baseLineWidth = prop.baseLineWidth, let baseArcColor = prop.baseArcColor {
            let circular: ArcView = ArcView(frame: rect, lineWidth: baseLineWidth)
            circular.prop = prop
            circular.ratio = 1.0
            circular.color = baseArcColor
            circular.lineWidth = baseLineWidth
            addSubview(circular)
        }
        
        // Gradient Circular
        if ColorUtil.toRGBA(color: prop.startArcColor).a < 1.0 || ColorUtil.toRGBA(color: prop.endArcColor).a < 1.0 {
            // Clear Color
            let gradient: UIView = GradientArcWithClearColorView().draw(rect: rect, prop: prop)
            addSubview(gradient)
            
            masking(rect: rect, prop: prop, gradient: gradient)
            
        } else {
            // Opaque Color
            let gradient: GradientArcView = GradientArcView(frame: rect)
            gradient.prop = prop
            addSubview(gradient)
            
            masking(rect: rect, prop: prop, gradient: gradient)
        }
    }
    
    private func masking(rect: CGRect, prop: Property, gradient: UIView) {
        // Mask
        arcView = ArcView(frame: rect, lineWidth: prop.arcLineWidth)
        
        guard let mask = arcView else {
            return
        }
        
        mask.prop = prop
        gradient.layer.mask = mask.layer
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let mask = arcView else {
            return
        }
        
        if ratio > 1.0 {
            mask.ratio = 1.0
        } else {
            mask.ratio = ratio
        }
        mask.setNeedsDisplay()
    }
    
    func showRatio() {
        
        guard let prop = prop else {
            return
        }
        
        // Progress Ratio
        ratioLabel.text = ""
        ratioLabel.font = prop.ratioLabelFont
        ratioLabel.textAlignment = NSTextAlignment.right
        ratioLabel.textColor = prop.ratioLabelFontColor
        ratioLabel.sizeToFit()
        ratioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(ratioLabel)
        self.setRatioLabelConstraints()
    }
    
    func setRatioLabelConstraints() {
        let hConstraint = NSLayoutConstraint.init(item: ratioLabel,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
        let vConstraint = NSLayoutConstraint.init(item: ratioLabel,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerY,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
        addConstraints([hConstraint, vConstraint])
    }
}
