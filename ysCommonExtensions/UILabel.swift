//
//  UILabel.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import UIKit

extension UILabel {
    
    func setLineHeightAndLetterSpacing(lineHeight: CGFloat, letterSpacing: CGFloat) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttributes([
            .kern: letterSpacing,
            .paragraphStyle: paragraphStyle,
            .baselineOffset: (lineHeight - font.lineHeight) / 4
        ], range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func changeTextColor(color: UIColor, range: NSRange) {
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: text.stringValue() ?? "")
        }
        
        attributedString.addAttributes([.foregroundColor: color], range: range)
        
        self.attributedText = attributedString
    }
    
    func heightForView() -> CGFloat{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
}
