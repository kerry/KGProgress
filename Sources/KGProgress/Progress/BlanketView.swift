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
    
    init(view: UIView, style: StyleProperty) {
        super.init(frame: view.frame)
        initialize(view: view, style: style)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func initialize(view: UIView, style: StyleProperty) {
        clipsToBounds = true
        backgroundColor = style.blanketColor!
        alpha = style.blanketOpacity!
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.setViewConstraints(view: view)
    }
    
    private func setViewConstraints(view: UIView) {
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[blanket]-0-|",
                                                          options: .directionLeftToRight,
                                                          metrics: nil,
                                                          views: ["blanket": self])
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[blanket]-0-|",
                                                          options: .directionLeftToRight,
                                                          metrics: nil,
                                                          views: ["blanket": self])
        view.addConstraints(hConstraints)
        view.addConstraints(vConstraints)
    }
}
