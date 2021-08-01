//
//  UIImageView+Letu.swift
//  LETU
//
//  Created by Никита on 3/19/20.
//  Copyright © 2020 Л'Этуаль. All rights reserved.
//

import UIKit

extension UIImageView {
    
    var hasContent: Bool {
        self.image != nil
    }
    
    /// Calculate width based on height by aspect ratio of content
    func width(forHeight height: CGFloat) -> CGFloat {
        guard let image = image else { return .zero }
        let widthMultiplier = image.size.width / image.size.height
        let newWidth = widthMultiplier * height
        return newWidth
    }
    
    /// Calculate height based on width by aspect ratio of content
    func height(forWidth width: CGFloat) -> CGFloat {
        guard let image = image else { return .zero }
        let heightMultiplier = image.size.height / image.size.width
        let newHeight = heightMultiplier * width
        return newHeight
    }
    
    /// Recalculate content size based on height provided based on aspect ratio
    func recalculate(byHeight height: CGFloat) {
        anchor(size: .init(width: width(forHeight: height), height: height))
    }
    
    /// Recalculate content size based on width provided based on aspect ratio
    func recalculate(byWidth width: CGFloat) {
        anchor(size: .init(width: width, height: height(forWidth: width)))
    }
}
