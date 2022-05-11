//
//  Numeric.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import Foundation

extension Numeric {
    
    var delimiter: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "en_US")
        return numberFormatter.string(for: self) ?? "\(self)"
    }
    
    var stringValue: String {
      return "\(self)"
    }
    
}
