//
//  BlanketView.swift
//  KGProgressSample
//
//  Created by Pratik Grover on 13/02/17.
//  Copyright © 2017 Prateek Grover. All rights reserved.
//

import Foundation
import UIKit

class BlanketView: UIView {
    
    private var viewRect: CGRect?
    
    init(frame: CGRect, style: StyleProperty) {
        super.init(frame: frame)
        
        initialize(frame: frame, style: style)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func initialize(frame: CGRect, style: StyleProperty) {
        viewRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        clipsToBounds = true
        
        backgroundColor = style.blanketColor!
        alpha = style.blanketOpacity!
    }
}
