//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by Sercan on 9.11.2017.
//  Copyright © 2017 Sercan Orhangazi. All rights reserved.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.831372549, blue: 0.3137254902, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.4, green: 1, blue: 0.4901960784, alpha: 1)
    }
}
