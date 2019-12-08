//
//  Extension+View.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

extension UIView {
    
    func circle() {
        self.layer.cornerRadius = self.layer.frame.height / 2.0
    }
    
    func roundBorder(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

}
