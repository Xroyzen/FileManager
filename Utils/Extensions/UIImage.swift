//
//  UIImage.swift
//  
//
//  Created by Никита on 19.07.21.
//

import UIKit

extension UIImage {
    
    convenience init?(named name: ImageName) {
        self.init(named: name.rawValue, in: .main, compatibleWith: nil)
    }
}
