//
//  KGProgress.swift
//  KGProgress
//
//  Created by kerry
//

import UIKit

//internal var baseWindow: BaseWindow?

public class KGProgress {
    
    fileprivate var progressView: ProgressView?
    fileprivate var blanketView: BlanketView?
    fileprivate var property: Property?
    
    public var isAvailable: Bool = false
    
    public init() {}
}

// MARK: Common
extension KGProgress {
    
    public func updateMessage(message: String) {
        if !isAvailable {
            return
        }
        
        // Use addSubView
        if let v = progressView {
            v.updateMessage(message)
        }
    }
    
    public func updateRatio(_ ratio: CGFloat) {
        if !isAvailable {
            return
        }
        
        // Use addSubView
        if let v = progressView {
            v.ratio = ratio
        }
    }
}

// MARK: Use addSubView
extension KGProgress {
    
    public func showAtRatio(display: Bool = true,
                            message: String? = nil,
                            view: UIView,
                            style: StyleProperty = Style()) {
        if isAvailable {
            return
        }
        isAvailable = true
        property = Property(style: style)
        
        if style.hasBlanket {
            //get blanket and call progress view there
            blanketView = BlanketView(view: view,
                                      style: style)
            
            guard let b = blanketView else {
                return
            }
            
            createProgressViewWithRatio(view: view,
                                       display: display,
                                       message: message,
                                       style: style)
            
        } else {
            createProgressViewWithRatio(view: view,
                                        display: display,
                                        message: message,
                                        style: style)
            
        }
    }
    
    public func show(message: String?,
                     view: UIView,
                     style: StyleProperty = Style()) {
        if isAvailable {
            return
        }
        isAvailable = true
        property = Property(style: style)
        
        setProgress(message: message,
                    view: view,
                    style: style)
    }
    
    private func setProgress(message: String?,
                             view: UIView,
                             style: StyleProperty) {
        
        if style.hasBlanket {
            //get blanket and call progress view there
            blanketView = BlanketView(view: view,
                                      style: style)
            
            guard let b = blanketView else {
                return
            }
            
            createProgressView(view: view,
                               message: message,
                               style: style)
            
        } else {
            createProgressView(view: view,
                               message: message,
                               style: style)
        }
    }
    
    private func createProgressView(view: UIView, message: String?, style: StyleProperty) {
        progressView = ProgressView(view: view, size: style.containerSize)
        
        guard let v = progressView else {
            return
        }
        
        v.circle(message, style: style)
    }
    
    private func createProgressViewWithRatio(view: UIView, display: Bool, message: String?, style: StyleProperty) {
        progressView = ProgressView(view: view, size: style.containerSize)
        
        guard let v = progressView else {
            return
        }
        
        v.arc(display, message: message, style: style)
    }
    
    public func dismiss() {
        if !isAvailable {
            return
        }
        
        guard let prop = property else {
            return
        }
        
        if prop.hasBlanket {
            self.blanketView?.removeFromSuperview()
        }
        
        guard let view = self.progressView else {
            self.property = nil
            isAvailable = false
            return
        }
        
        cleanup(prop.dismissTimeInterval!, view: view, completionHandler: nil)
    }
    
    public func dismiss(completionHandler: @escaping () -> Void) -> () {
        if !isAvailable {
            return
        }
        
        guard let prop = property else {
            return
        }
        
        guard let view = self.progressView else {
            self.property = nil
            isAvailable = false
            return
        }
        
        cleanup(prop.dismissTimeInterval!, view: view) { Void in
            completionHandler()
        }
    }
    
    private func cleanup(_ t: Double, view: UIView, completionHandler: (() -> Void)?) {
        let delay = t * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time) {
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    view.alpha = 0
                    self.blanketView?.alpha = 0
            },
                completion: { [weak self] finished in
                    view.removeFromSuperview()
                    self?.blanketView?.removeFromSuperview()
                    self?.property = nil
                    self?.isAvailable = false
                    guard let completionHandler = completionHandler else {
                        return
                    }
                    completionHandler()
                }
            )
        }
    }
}
