//
//  NSAttributedStringExtensions.swift
//  LETU
//
//  Created by Dmitrii Tsvetkov on 4/4/17.
//  Copyright © 2017 EPAM. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
    
    func textHeight(width: CGFloat) -> CGFloat {
        let textStorage = NSTextStorage(attributedString: self)
        let textContainer = NSTextContainer(size: CGSize(width: width, height: .infinity))
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0
        layoutManager.glyphRange(for: textContainer)
        return layoutManager.usedRect(for: textContainer).size.height
    }
    
    func boundingRect(forSize size: CGSize) -> CGRect {
        return self.boundingRect(with: size,
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    context: nil)
    }
}
