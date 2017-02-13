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
    
    public func showAtRatio(frame: CGRect,
                            display: Bool = true,
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
            blanketView = BlanketView(frame: CGRect(origin: .zero,
                                                    size: CGSize(width: view.bounds.width,
                                                                 height: view.bounds.height)),
                                      style: style)
            
            guard let b = blanketView else {
                return
            }
            
            let progressView = createProgressViewWithRatio(frame: frame, display: display, message: message, style: style)
            
            guard let pv = progressView else {
                return
            }
            
            view.addSubview(b)
            view.addSubview(pv)
            view.bringSubview(toFront: pv)
        } else {
            let progressView = createProgressViewWithRatio(frame: frame, display: display, message: message, style: style)
            guard let pv = progressView else {
                return
            }
            view.addSubview(pv)
        }
    }
    
    public func show(frame: CGRect,
                     message: String?,
                     view: UIView,
                     style: StyleProperty = Style()) {
        if isAvailable {
            return
        }
        isAvailable = true
        property = Property(style: style)
        
        setProgress(frame: frame,
                    message: message,
                    view: view,
                    style: style)
    }
    
    private func setProgress(frame: CGRect,
                             message: String?,
                             view: UIView,
                             style: StyleProperty) {
        
        if style.hasBlanket {
            //get blanket and call progress view there
            blanketView = BlanketView(frame: CGRect(origin: .zero,
                                                    size: CGSize(width: UIScreen.main.bounds.width,
                                                                 height: UIScreen.main.bounds.height)),
                                      style: style)
            
            guard let b = blanketView else {
                return
            }
            
            let progressView = createProgressView(frame: frame, message: message, style: style)
            
            guard let pv = progressView else {
                return
            }
            
            view.addSubview(b)
            view.addSubview(pv)
            view.bringSubview(toFront: pv)
        } else {
            let progressView = createProgressView(frame: frame, message: message, style: style)
            guard let pv = progressView else {
                return
            }
            view.addSubview(pv)
        }
    }
    
    private func createProgressView(frame: CGRect, message: String?, style: StyleProperty) -> UIView? {
        progressView = ProgressView(frame: frame)
        
        guard let v = progressView else {
            return nil
        }
        
        v.circle(message, style: style)
        
        return v
    }
    
    private func createProgressViewWithRatio(frame: CGRect, display: Bool, message: String?, style: StyleProperty) -> UIView? {
        progressView = ProgressView(frame: frame)
        
        guard let v = progressView else {
            return nil
        }
        
        v.arc(display, message: message, style: style)
        
        return v
    }
    
    public func dismiss(progress view: UIView) {
        if !isAvailable {
            return
        }
        
        guard let prop = property else {
            return
        }
        
        cleanup(prop.dismissTimeInterval!, view: view, completionHandler: nil)
    }
    
    public func dismiss(progress view: UIView, completionHandler: @escaping () -> Void) -> () {
        if !isAvailable {
            return
        }
        
        guard let prop = property else {
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
                },
                completion: { [weak self] finished in
                    view.removeFromSuperview()
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
