//
//  Background.swift
//  KGProgress
//
//  Created by kerry
//
import UIKit

struct Background {
    
    internal func blurEffectView(frame: CGRect) -> UIView? {
        
        var blurView: UIView?
        
        blurView = UIView()
        
        blurView?.frame = frame
        return blurView
    }
    
//    private func getStyle(_ style: BackgroundStyles) -> (blurEffectStyle: UIBlurEffectStyle?, isUserInteraction: Bool) {
//        switch style {
//        case .white:
//            return (nil, false)
//        default:
//            // .none
//            return (nil, true)
//        }
//    }
}
