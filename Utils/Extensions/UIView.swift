//
//  UIView.swift
//  
//
//  Created by Никита on 6.07.21.
//

import UIKit

extension UIView {
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func setIsHidden(_ hidden: Bool, animated: Bool) {
        if animated {
            if self.isHidden && !hidden {
                self.alpha = 0.0
                self.isHidden = false
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = hidden ? 0.0 : 1.0
            }) { (complete) in
                self.isHidden = hidden
            }
        } else {
            self.isHidden = hidden
        }
    }
    
    // MARK: Setup constraints:
    
    func anchor(centerY: NSLayoutYAxisAnchor? = nil,
                centerX: NSLayoutXAxisAnchor? = nil,
                top: NSLayoutYAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                greaterThanOrEqualToLeft: NSLayoutXAxisAnchor? = nil,
                greaterThanOrEqualToRight: NSLayoutXAxisAnchor? = nil,
                lessThanOrEqualToLeft: NSLayoutXAxisAnchor? = nil,
                lessThanOrEqualToRight: NSLayoutXAxisAnchor? = nil,
                widthAnchor: NSLayoutDimension? = nil,
                heightAnchor: NSLayoutDimension? = nil,
                paddingTop: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0,
                multiplier: CGFloat = 1) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let widthA = widthAnchor {
            self.widthAnchor.constraint(equalTo: widthA, multiplier: multiplier, constant: -(paddingLeft + paddingRight)).isActive = true
        }
        
        if let heightA = heightAnchor {
            self.heightAnchor.constraint(equalTo: heightA, multiplier: multiplier, constant: -(paddingTop + paddingBottom)).isActive = true
        }
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bot = bottom {
            self.bottomAnchor.constraint(equalTo: bot, constant: -paddingBottom).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let greaterThanOrEqualToLeft = greaterThanOrEqualToLeft {
            self.leftAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualToLeft, constant: paddingLeft).isActive = true
        }
        
        if let greaterThanOrEqualToRight = greaterThanOrEqualToRight {
            self.rightAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualToRight, constant: -paddingRight).isActive = true
        }
        
        if let lessThanOrEqualToLeft = lessThanOrEqualToLeft {
            self.leftAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualToLeft, constant: paddingLeft).isActive = true
        }
        
        if let lessThanOrEqualToRight = lessThanOrEqualToRight {
            self.rightAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualToRight, constant: -paddingRight).isActive = true
        }
        
        if height != 0 {
            let roundedHeight = height.rounded()
            self.heightAnchor.constraint(equalToConstant: roundedHeight).isActive = true
        }
        
        if width != 0 {
            let roundedWidth = width.rounded()
            self.widthAnchor.constraint(equalToConstant: roundedWidth).isActive = true
        }
    }
    
    func anchor(centerY: NSLayoutYAxisAnchor? = nil,
                centerX: NSLayoutXAxisAnchor? = nil,
                top: NSLayoutYAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                widthAnchor: NSLayoutDimension? = nil,
                heightAnchor: NSLayoutDimension? = nil,
                insets: UIEdgeInsets = .zero,
                size: CGSize = .zero,
                multiplier: CGFloat = 1) {
        anchor(centerY: centerY,
                centerX: centerX,
                top: top,
                bottom: bottom,
                left: left,
                right: right,
                widthAnchor: widthAnchor,
                heightAnchor: heightAnchor,
                paddingTop: insets.top,
                paddingBottom: insets.bottom,
                paddingLeft: insets.left,
                paddingRight: insets.right,
                width: size.width,
                height: size.height,
                multiplier: multiplier)
    }
    
    func fill(to parent: UIView, insets: UIEdgeInsets = .zero, size: CGSize = .zero) {
        anchor(top: parent.safeAreaLayoutGuide.topAnchor,
                bottom: parent.safeAreaLayoutGuide.bottomAnchor,
                left: parent.safeAreaLayoutGuide.leftAnchor,
                right: parent.safeAreaLayoutGuide.rightAnchor,
                insets: insets,
                size: size)
    }
    
    func animatePushDown() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }
    }
    
    func animatePushUp() {
        UIView.animate(withDuration: 0.3) {
            self.transform = .identity
        }
    }
    
    func constraint(_ constraintAttributes: [NSLayoutConstraint.Attribute]) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            return NSLayoutConstraint()
        }
        
        for constraint in superview.constraints {
            for attributes in constraintAttributes {
                if constraint.firstAttribute == attributes && constraint.isActive && self == constraint.secondItem as? UIView {
                    return constraint
                }
                
                if constraint.secondAttribute == attributes && constraint.isActive && self == constraint.firstItem as? UIView {
                    return constraint
                }
            }
        }
        
        return NSLayoutConstraint()
    }

    func removeConstraints() {
        let constraints = superview?.constraints.filter {
            $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
        } ?? []
        superview?.removeConstraints(constraints)
    }
}
