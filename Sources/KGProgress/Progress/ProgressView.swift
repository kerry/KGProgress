//
//  ProgressView.swift
//  KGProgress
//
//  Created by kerry
//

import UIKit

class ProgressView: UIView {
    
    private var progressAtRatioView: ProgressAtRatioView?
    private var circularProgressView: CircularProgressView?
    internal var prop: Property?
    var messageLabel = UILabel()
    
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
            let attr = [kCTParagraphStyleAttributeName: paragraphStyle]
            let attributedString = NSMutableAttributedString(string: message, attributes: attr as [NSAttributedString.Key : Any])
            
            messageLabel.attributedText = attributedString
            messageLabel.sizeToFit()
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
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messageLabel)
        
        self.message = message
    }
    
    internal var ratio: CGFloat = 0.0 {
        didSet {
            progressAtRatioView?.ratio = ratio
            progressAtRatioView?.setNeedsDisplay()
        }
    }
    
    init(view: UIView, size: CGSize) {
        super.init(frame: view.frame)
        translatesAutoresizingMaskIntoConstraints = false
        initialize(view: view, size: size)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func initialize(view: UIView, size: CGSize) {
        clipsToBounds = true
        view.addSubview(self)
        self.setViewConstraints(view: view, size: size)
    }
    
    func setViewConstraints(view: UIView, size: CGSize) {
        let hConstraint = NSLayoutConstraint.init(item: self,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
        let vConstraint = NSLayoutConstraint.init(item: self,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .centerY,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
        
        let heightConstraint = NSLayoutConstraint.init(item: self,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1.0,
                                                       constant: size.height)
        
        let widthConstraint = NSLayoutConstraint.init(item: self,
                                                       attribute: .width,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1.0,
                                                       constant: size.width)
        view.addConstraints([hConstraint, vConstraint, heightConstraint, widthConstraint])
    }
    
    internal func arc(_ display: Bool, message: String?, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let prop = prop else {
            return
        }
        
        isUserInteractionEnabled = false
        
        setContainerView()
        
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
            showMessage(message)
            self.setProgressCircleConstraints(view: progressAtRatioView, style: style, yMultiplier: 4.0/5.0)
            self.setMessageLabelConstraints(view: progressAtRatioView)
        } else {
            self.setProgressCircleConstraints(view: progressAtRatioView, style: style, yMultiplier: 1.0)
        }
        
        addSubview(progressAtRatioView)
    }
    
    internal func circle(_ message: String?, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let prop = prop else {
            return
        }
        
        isUserInteractionEnabled = false
        
        setContainerView()
        
        circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: prop.progressSize, height: prop.progressSize))
        
        guard let circularProgressView = circularProgressView else {
            return
        }
        
        circularProgressView.prop = prop
        circularProgressView.initialize(frame: circularProgressView.frame)
        addSubview(circularProgressView)

        if prop.hasMessage, let message = message {
            showMessage(message)
            self.setProgressCircleConstraints(view: circularProgressView, style: style, yMultiplier: 4.0/5.0)
            self.setMessageLabelConstraints(view: circularProgressView)
        } else {
            self.setProgressCircleConstraints(view: circularProgressView, style: style, yMultiplier: 1.0)
        }
    }
    
    func setMessageLabelConstraints(view: UIView) {
        let hConstraint = NSLayoutConstraint.init(item: messageLabel,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .centerX,
                                              multiplier: 1.0,
                                              constant: 0.0)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-20-[messageLabel]",
                                                          options: .directionLeftToRight,
                                                          metrics: nil,
                                                          views: ["view": view, "messageLabel": messageLabel])
        addConstraint(hConstraint)
        addConstraints(vConstraints)
    }
    
    func setProgressCircleConstraints(view: UIView, style: StyleProperty, yMultiplier: CGFloat) {
        let hConstraint = NSLayoutConstraint.init(item: view,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
        let vConstraint = NSLayoutConstraint.init(item: view,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerY,
                                                  multiplier: yMultiplier,
                                                  constant: 0.0)
        let heightConstraint = NSLayoutConstraint.init(item: view,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1.0,
                                                       constant: style.progressSize)
        let widthConstraint = NSLayoutConstraint.init(item: view,
                                                      attribute: .width,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1.0,
                                                      constant: style.progressSize)
        
        addConstraints([hConstraint, vConstraint, heightConstraint, widthConstraint])
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
    
    private func setContainerView() {
        
        guard let prop = prop else {
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
    }
}
