//
//  String.swift
//  LETU
//
//  Created by Dmitrii Tsvetkov on 9/6/16.
//  Copyright © 2016 EPAM. All rights reserved.
//

import UIKit


extension String {
    
    var withoutExtraWhitespaces: String {
        let components = self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    var hasContent: Bool {
        let result = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return result.isEmpty == false
    }
    
    func withLineHeightMultiple(_ height: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = height
        let attributedString = NSAttributedString(string: self, attributes: [.paragraphStyle: paragraphStyle])
        return attributedString
    }
    
    // Extension for matching regex patterns
    func matchesToPattern(_ pattern: String) -> [NSTextCheckingResult] {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        guard let validRegex = regex else { return [] }
        let nsstr = self as NSString
        let all = NSRange(location: 0, length: nsstr.length)
        return validRegex.matches(in: self, options: [], range: all)
    }
    
    // Append URL querystring parameter
    func stringByAppendingURLParameter(_ name: String, value: String) -> String {
        let linkSymbol = self.contains("?") ? "&" : "?"
        let result = self + linkSymbol + name + "=" + value
        return result
    }
    
    func stringByReplacingNSRange(_ range: NSRange, with: String) -> String {
        let indexRange = self.indexRangeFromStartIndex(self.startIndex, inRange: range)
        return self.replacingCharacters(in: indexRange, with: with)
    }
    
    func substringWithNSRange(_ range: NSRange) -> String? {
        guard let range = Range(range, in: self) else { return nil }
        return String(self[range])
    }
    
    func stringByReplacing(_ strings: [String]) -> String {
        var result = self
        strings.forEach {
            result = result.replacingOccurrences(of: $0, with: "")
        }
        return result
    }

    func indexRangeFromStartIndex(_ startIndex: String.Index, inRange: NSRange) -> Range<String.Index> {
        let indexRange = index(startIndex, offsetBy: inRange.location) ..< index(startIndex, offsetBy: inRange.location + inRange.length - 1)
        return indexRange
    }
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }

    /**
     Checks email address
     - returns: true - email is valid
     */

    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

}
