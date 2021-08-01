//
//  UIColor.swift
//  
//
//  Created by Никита on 19.07.21.
//

import UIKit

extension UIColor {
    
    convenience init?(_ color: ColorName) {
        self.init(named: color.rawValue, in: .main, compatibleWith: nil)
    }
}
