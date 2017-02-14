//
//  DefaultStyle.swift
//  KGProgress
//
//  Created by kerry
//
import Foundation
import UIKit

public struct Style: StyleProperty {
    // Progress Size
    public var containerSize: CGSize = CGSize(width: 150, height: 150)
    public var progressSize: CGFloat = 44
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 2.0
    public var startArcColor: UIColor = UIColor.white
    public var endArcColor: UIColor = ColorUtil.toUIColor(r: 239, g: 64, b: 61, a: 1.0)
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 2.0
    public var baseArcColor: UIColor? = UIColor.gray
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont.systemFont(ofSize: 12.0)
    public var ratioLabelFontColor: UIColor? = UIColor.black
    
    // Message
    public var hasMessage: Bool = true
    public var messageLabelFont: UIFont? = UIFont.systemFont(ofSize: 14.0)
    public var messageLabelFontColor: UIColor? = ColorUtil.toUIColor(r: 128, g: 128, b: 128, a: 1.0)
    
    // Background
//    public var backgroundStyle: BackgroundStyles = .white
    public var backgroundColor: UIColor? = .white
    public var backgroundCornerRadius: CGFloat? = 10
    public var hasBackgroundShadow: Bool = true
    public var backgroundShadowOpacity: CGFloat? = 0.2
    public var backgroundShadowRadius: CGFloat? = 5
    public var backgroundShadowOffset: CGSize? = CGSize(width: 0, height: 0)
    
    //Blanket
    public var hasBlanket: Bool = true
    public var blanketOpacity: CGFloat? = 0.2
    public var blanketColor: UIColor? = .black
    
    // Dismiss
    public var dismissTimeInterval: Double? = nil // 'nil' for default setting.
    
    public init() {}
}
