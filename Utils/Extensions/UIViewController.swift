//
//  LTViewController.swift
//  
//
//  Created by Никита on 6.07.21.
//

import UIKit

extension UIViewController {
    
    func addHandlerKeyboardToTappedAround() {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        gesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
