//
//  Property.swift
//  KGProgress
//
//  Created by kerry
//
import UIKit

public protocol StyleProperty {
    // Progress Size
    var progressSize: CGFloat { get set }
    
    // Gradient Circular
    var arcLineWidth: CGFloat { get set }
    var startArcColor: UIColor { get set }
    var endArcColor: UIColor { get set }
    
    // Base Circular
    var baseLineWidth: CGFloat? { get set }
    var baseArcColor: UIColor? { get set }
    
    // Ratio
    var ratioLabelFont: UIFont? { get set }
    var ratioLabelFontColor: UIColor? { get set }
    
    // Message
    var hasMessage: Bool { get set }
    var messageLabelFont: UIFont? { get set }
    var messageLabelFontColor: UIColor? { get set }
    
    // Background
//    var backgroundStyle: BackgroundStyles { get set }
    var backgroundColor: UIColor? { get set }
    var hasBackgroundShadow: Bool { get set }
    var backgroundCornerRadius: CGFloat? { get set }
    var backgroundShadowOpacity: CGFloat? { get set }
    var backgroundShadowOffset: CGSize? { get set }
    var backgroundShadowRadius: CGFloat? { get set }
    
    //Blanket
    var hasBlanket: Bool { get set }
    var blanketOpacity: CGFloat? { get set }
    var blanketColor: UIColor? { get set }
    
    // Dismiss
    var dismissTimeInterval: Double? { get set }
    
    // Initialize
    init()
}

//public enum BackgroundStyles: Int {
//    case white = 0
//}


internal struct Property {
    let margin: CGFloat = 5.0
    let arcLineCapStyle: CGLineCap = CGLineCap.butt
    
    // Progress Size
    var progressSize: CGFloat
    
    // Gradient Circular
    var arcLineWidth: CGFloat
    var startArcColor: UIColor
    var endArcColor: UIColor
    
    // Base Circular
    var baseLineWidth: CGFloat?
    var baseArcColor: UIColor?
    
    // Ratio
    let ratioLabelFont: UIFont?
    let ratioLabelFontColor: UIColor?
    
    // Message
    let hasMessage: Bool
    let messageLabelFont: UIFont?
    let messageLabelFontColor: UIColor?
    
    // Background
//    let backgroundStyle: BackgroundStyles
    let backgroundColor: UIColor?
    let hasBackgroundShadow: Bool
    let backgroundCornerRadius: CGFloat?
    let backgroundShadowOpacity: CGFloat?
    let backgroundShadowOffset: CGSize?
    let backgroundShadowRadius: CGFloat?
    
    //Blanket
    let hasBlanket: Bool
    let blanketOpacity: CGFloat?
    let blanketColor: UIColor?
    
    // Dismiss
    let dismissTimeInterval: Double?
    
    // Progress Rect
    var progressRect: CGRect {
        let lineWidth: CGFloat = (arcLineWidth > baseLineWidth!) ? arcLineWidth : baseLineWidth!
        return CGRect(x: 0, y: 0, width: progressSize - lineWidth * 2, height: progressSize - lineWidth * 2)
    }
    
    init(style: StyleProperty) {
        
        let styles: StyleProperty = style
        
        progressSize          = styles.progressSize
        arcLineWidth          = styles.arcLineWidth
        startArcColor         = styles.startArcColor
        endArcColor           = styles.endArcColor
        baseLineWidth         = styles.baseLineWidth         ?? 0.0
        baseArcColor          = styles.baseArcColor          ?? UIColor.clear
        ratioLabelFont        = styles.ratioLabelFont        ?? UIFont.systemFont(ofSize: 16.0)
        ratioLabelFontColor   = styles.ratioLabelFontColor   ?? UIColor.clear
        hasMessage            = styles.hasMessage
        messageLabelFont      = styles.messageLabelFont      ?? UIFont.systemFont(ofSize: 16.0)
        messageLabelFontColor = styles.messageLabelFontColor ?? UIColor.clear
//        backgroundStyle       = styles.backgroundStyle
        backgroundColor       = styles.backgroundColor ?? UIColor.white
        hasBackgroundShadow   = styles.hasBackgroundShadow
        backgroundCornerRadius = styles.backgroundCornerRadius ?? 5
        backgroundShadowOpacity = styles.backgroundShadowOpacity ?? 0.2
        backgroundShadowOffset = styles.backgroundShadowOffset ?? CGSize(width: 0, height: 2)
        backgroundShadowRadius = styles.backgroundShadowRadius ?? 5.0
        hasBlanket = styles.hasBlanket
        blanketOpacity = styles.blanketOpacity ?? 0.5
        blanketColor = styles.blanketColor ?? .black
        dismissTimeInterval   = styles.dismissTimeInterval    ?? 0.8
    }
}
