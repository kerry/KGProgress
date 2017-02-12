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
    public var progressSize: CGFloat = 66
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 4.0
    public var startArcColor: UIColor = UIColor.white
    public var endArcColor: UIColor = UIColor.red
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 4.0
    public var baseArcColor: UIColor? = UIColor.gray
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont.systemFont(ofSize: 12.0)
    public var ratioLabelFontColor: UIColor? = UIColor.black
    
    // Message
    public var hasMessage: Bool = false
    public var messageLabelFont: UIFont? = UIFont.systemFont(ofSize: 16.0)
    public var messageLabelFontColor: UIColor? = UIColor.black
    
    // Background
//    public var backgroundStyle: BackgroundStyles = .white
    public var backgroundColor: UIColor? = .white
    public var backgroundCornerRadius: CGFloat? = 10
    public var hasBackgroundShadow: Bool = true
    public var backgroundShadowOpacity: CGFloat? = 0.2
    public var backgroundShadowRadius: CGFloat? = 5
    public var backgroundShadowOffset: CGSize? = CGSize(width: 0, height: 2)
    
    // Dismiss
    public var dismissTimeInterval: Double? = nil // 'nil' for default setting.
    
    public init() {}
}
