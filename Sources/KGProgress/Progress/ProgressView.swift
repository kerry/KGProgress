//
//  ProgressView.swift
//  KGProgress
//
//  Created by kerry
//

import UIKit

class ProgressView: UIView {
    
    private var viewRect: CGRect?
    private var blurView: UIView?
    private var progressAtRatioView: ProgressAtRatioView?
    private var circularProgressView: CircularProgressView?
    internal var prop: Property?
    var messageLabel = UILabel()
    var centerPoint: CGPoint?
    
    var message: String? {
        willSet {
            messageLabel.frame = frame
            messageLabel.text = newValue
            
            guard let message = messageLabel.text else {
                return
            }
            
            // Attribute
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.2
            paragraphStyle.alignment = NSTextAlignment.center
            let attr = [NSParagraphStyleAttributeName: paragraphStyle]
            let attributedString = NSMutableAttributedString(string: message, attributes: attr)
            
            messageLabel.attributedText = attributedString
            messageLabel.sizeToFit()
            messageLabel.backgroundColor = UIColor.orange
            
            if centerPoint == nil {
                centerPoint = center
            }
            
            if let center = centerPoint {
                messageLabel.center = center
            }
        }
    }
    
    internal func showMessage(_ message: String) {
        
        guard let prop = prop else {
            return
        }
        
        // Message
        messageLabel.font = prop.messageLabelFont
        messageLabel.textAlignment = NSTextAlignment.center
        messageLabel.textColor = prop.messageLabelFontColor
        messageLabel.numberOfLines = 0
        
        addSubview(messageLabel)
        
        self.message = message
    }
    
    internal var ratio: CGFloat = 0.0 {
        didSet {
            progressAtRatioView?.ratio = ratio
            progressAtRatioView?.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func initialize(frame: CGRect) {
        viewRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        clipsToBounds = true
    }
    
    internal func arc(_ display: Bool, message: String?, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let prop = prop else {
            return
        }
        
//        isUserInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false
        isUserInteractionEnabled = false
        
        getBlurView()
        
        progressAtRatioView = ProgressAtRatioView(frame: CGRect(x: 0, y: 0, width: prop.progressSize, height: prop.progressSize))
        
        guard let progressAtRatioView = progressAtRatioView else {
            return
        }
        
        progressAtRatioView.prop = prop
        progressAtRatioView.initialize(frame: progressAtRatioView.frame)
        
        if display {
            progressAtRatioView.showRatio()
        }
        
        if prop.hasMessage, let message = message {
            self.centerPoint = CGPoint(x: frame.size.width/2, y: frame.size.height*3/4)
            showMessage(message)
            progressAtRatioView.frame = CGRect(
                x: (frame.size.width - progressAtRatioView.frame.size.width) / 2,
                y: (frame.size.height/3 - progressAtRatioView.frame.size.height/2),
                width: progressAtRatioView.frame.size.width,
                height: progressAtRatioView.frame.size.height)
        } else {
            progressAtRatioView.frame = CGRect(
                x: (frame.size.width - progressAtRatioView.frame.size.width) / 2,
                y: (frame.size.height - progressAtRatioView.frame.size.height) / 2,
                width: progressAtRatioView.frame.size.width,
                height: progressAtRatioView.frame.size.height)
        }
        
        addSubview(progressAtRatioView)
    }
    
    internal func circle(_ message: String?, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let prop = prop else {
            return
        }
        
//        isUserInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false
        isUserInteractionEnabled = false
        
        getBlurView()
        
        circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: prop.progressSize, height: prop.progressSize))
        
        guard let circularProgressView = circularProgressView else {
            return
        }
        
        circularProgressView.prop = prop
        circularProgressView.initialize(frame: circularProgressView.frame)
        
        if prop.hasMessage, let message = message {
            self.centerPoint = CGPoint(x: frame.size.width/2, y: frame.size.height*3/4)
            showMessage(message)
            circularProgressView.frame = CGRect(
                x: (frame.size.width - circularProgressView.frame.size.width) / 2,
                y: (frame.size.height/3 - circularProgressView.frame.size.height/2),
                width: circularProgressView.frame.size.width,
                height: circularProgressView.frame.size.height)
        } else {
            circularProgressView.frame = CGRect(
                x: (frame.size.width - circularProgressView.frame.size.width) / 2,
                y: (frame.size.height - circularProgressView.frame.size.height) / 2,
                width: circularProgressView.frame.size.width,
                height: circularProgressView.frame.size.height)
        }
        
        addSubview(circularProgressView)
    }
    
    internal func updateMessage(_ message: String) {
        
        guard let _ = circularProgressView else {
            return
        }
        
        guard let prop = prop else {
            return
        }
        
        if !prop.hasMessage {
            return
        }
        
        self.message = message
    }
    
    private func getBlurView() {
        
        guard let rect = viewRect, let prop = prop else {
            return
        }
        
        blurView = Background().blurEffectView(frame: rect)
        
        guard let blurView = blurView else {
            return
        }
        
        self.backgroundColor = prop.backgroundColor!
        layer.cornerRadius = prop.backgroundCornerRadius!
        
        if prop.hasBackgroundShadow {
            layer.masksToBounds = false
            layer.shadowOffset = prop.backgroundShadowOffset!
            layer.shadowRadius = prop.backgroundShadowRadius!
            layer.shadowOpacity = Float(prop.backgroundShadowOpacity!)
        }
        addSubview(blurView)
    }
}
